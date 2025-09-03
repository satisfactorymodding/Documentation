import os
import subprocess
from pathlib import Path
import shutil
import logging

# Full path to vgmstream-cli.exe, usually in your FModel's Output Directory
# Example Path
VGMSTREAM = Path(r"C:/FModel/Output/.data/vgmstream-cli.exe")

# Logs
MAIN_LOG = "conversion_main.log"
FAILED_LOG = "conversion_errors.log"

# Setup main logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.FileHandler(MAIN_LOG, mode='w', encoding='utf-8'),
        logging.StreamHandler()
    ]
)

# Setup failed conversion logging (Will overwrite each run, could be replaced with RotatingFileHandler but needs script changes)
failed_logger = logging.getLogger("failed")
failed_handler = logging.FileHandler(FAILED_LOG, mode='w', encoding='utf-8')
failed_handler.setLevel(logging.ERROR)
failed_logger.addHandler(failed_handler)
failed_logger.propagate = False

# Counters for summary
total_wems = 0
converted_count = 0
skipped_count = 0
failed_count = 0

# Step 1: Convert all .wem files into ./out_temp/wem/ (flat), mapping to digit folders
def wem_to_wav(input_root, temp_root):
    global total_wems, converted_count, skipped_count, failed_count
    input_root = Path(input_root)
    temp_wem_root = Path(temp_root) / "wem"

    # CLEAN temp folder
    if temp_wem_root.exists():
        shutil.rmtree(temp_wem_root)
    temp_wem_root.mkdir(parents=True, exist_ok=True)

    mapping = {}  # wav filename -> digit folder

    for folder, _, files in os.walk(input_root):
        folder_path = Path(folder)

        # If we are in root (txtp/wem) use "root" as folder name
        digit_folder = "root" if folder_path == input_root else folder_path.name

        for file in files:
            ext = Path(file).suffix.lower()
            base_name = Path(file).stem
            wav_name = base_name + ".wav"

            wem_path = folder_path / file
            wav_path = temp_wem_root / wav_name
            mapping[wav_name] = digit_folder

            final_out_path = Path("out") / digit_folder / wav_name
            if wav_path.exists() or final_out_path.exists():
                skipped_count += 1
                logging.info(f"Skipping existing WAV: {wav_path} or {final_out_path}")
                continue

            if ext == ".wem":
                # Convert wem → wav
                logging.info(f"Converting: {wem_path} → {wav_path}")
                result = subprocess.run(
                    [str(VGMSTREAM), "-o", str(wav_path), str(wem_path)],
                    capture_output=True,
                    text=True
                )
                if result.returncode != 0 or not wav_path.exists():
                    failed_count += 1
                    logging.error(f"Conversion failed for {wem_path}: {result.stderr}")
                    failed_logger.error(str(wem_path))
                else:
                    converted_count += 1
                    logging.info(f"Converted {wem_path} successfully")

            elif ext == ".wav":
                # Copy pre-existing wav into temp for rename step
                try:
                    shutil.copy2(wem_path, wav_path)
                    skipped_count += 1
                    logging.info(f"Using existing WAV instead of converting: {wem_path} → {wav_path}")
                except Exception as e:
                    failed_count += 1
                    logging.error(f"Failed to copy existing WAV {wem_path}: {e}")
                    failed_logger.error(str(wem_path))
    return mapping

# Step 2: Rename .wav files based on .txtp references
def convert(filename, wav_root, out_root, mapping):
    wav_root = Path(wav_root)
    out_root = Path(out_root)
    txtp_path = Path("txtp") / filename

    try:
        with open(txtp_path, "r", encoding='utf-8') as my_file:
            data = my_file.read()
    except Exception as e:
        logging.error(f"Failed to read {txtp_path}: {e}")
        return

    tokens = data.replace('\n', ' ').split(" ")

    for i, token in enumerate(tokens):
        if token.startswith('wem'):
            wav_file_only = Path(token).stem + ".wav"
            wavname = wav_root / wav_file_only
            digit_folder = mapping.get(wavname.name, "unknown")
            out_folder = out_root / digit_folder
            out_folder.mkdir(parents=True, exist_ok=True)
            new_name = out_folder / f"{filename.split('.')[0]}_{i}.wav"

            if new_name.exists():
                logging.info(f"Skipping already renamed WAV: {new_name}")
                continue

            if wavname.exists():
                try:
                    shutil.move(str(wavname), str(new_name))
                    logging.info(f"Renamed {wavname} → {new_name}")
                except Exception as e:
                    logging.error(f"Failed to rename {wavname}: {e}")
            else:
                logging.warning(f"{wavname} not found.")

# Step 3: Retry failed conversions
def retry_failed_conversions(temp_wav_root):
    global converted_count, failed_count
    failed_path = Path(FAILED_LOG)
    if not failed_path.exists():
        logging.info("No failed conversions to retry.")
        return

    logging.info("Retrying failed conversions...")

    # Read and truncate the failed log for this retry
    with open(failed_path, "r+", encoding="utf-8") as f:
        failed_files = [line.strip() for line in f.readlines() if line.strip()]
        f.seek(0)
        f.truncate(0)

    new_failures = 0  # counter for files that fail again

    for wem_path_str in failed_files:
        wem_path = Path(wem_path_str)
        wav_name = wem_path.stem + ".wav"
        wav_path = temp_wav_root / wav_name

        if wav_path.exists():
            logging.info(f"Skipping existing WAV: {wav_path}")
            continue

        logging.info(f"Retrying conversion: {wem_path} → {wav_path}")
        result = subprocess.run(
            [str(VGMSTREAM), "-o", str(wav_path), str(wem_path)],
            capture_output=True,
            text=True
        )
        if result.returncode != 0 or not wav_path.exists():
            new_failures += 1
            logging.error(
                f"Conversion failed a 2nd time: {wem_path}. "
                "Either the .wem file is corrupt, broken, or there is no .txtp path for that file. "
                "Consider a manual approach or ask for help in the Discord."
            )
            failed_logger.error(str(wem_path))
        else:
            # Count as converted only if it actually succeeds now
            converted_count += 1
            logging.info(f"Successfully converted on retry: {wem_path}")

    # Update failed_count to reflect files that truly failed after retry
    failed_count = new_failures

# Main driver
if __name__ == "__main__":
    wem_root = Path("txtp/wem")
    wav_temp_root = Path("out_temp") / "wem"
    out_root = Path("out")

    logging.info("Starting .wem → .wav conversion")
    mapping = wem_to_wav(wem_root, Path("out_temp"))

    logging.info("Starting .wav renaming based on .txtp files")
    txtp_files = [f for f in Path("txtp").glob("*.txtp")]
    for file_path in txtp_files:
        convert(file_path.name, wav_temp_root, out_root, mapping)

    # Retry any failed conversions
    retry_failed_conversions(wav_temp_root)

    # Clean up temp folder
    if wav_temp_root.parent.exists():
        shutil.rmtree(wav_temp_root.parent)
        logging.info(f"Temporary folder {wav_temp_root.parent} deleted")

    # Final summary
    logging.info("===================================")
    logging.info(f"Total .wem files found: {total_wems}")
    logging.info(f"Successfully converted: {converted_count}")
    logging.info(f"Skipped (already exists): {skipped_count}")
    logging.info(f"Failed conversions: {failed_count}")
    logging.info("Conversion and renaming complete")
    logging.info("===================================")

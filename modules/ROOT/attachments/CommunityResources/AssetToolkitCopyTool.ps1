<#
.SYNOPSIS
    Asset Toolkit: Unreal Asset Copy Tool

.DESCRIPTION
    Copies custom assets from a (backup) Starter Project into your generated project.
    Skips invalid or missing paths and optionally copies StringTables.
    Logs all actions.
    Designed for saving time and better overview over what assets are copied.

.NOTES
    Author: Rovetown
    GitHub: https://github.com/Rovetown
    Discord: https://discord.gg/NdVyd7bef9
    Date: 22nd September 2025
#>

param()

# -------------------------
# CONFIG
# -------------------------
$CustomAssetListUrl = "https://raw.githubusercontent.com/satisfactorymodding/UnrealProjectUpdater/master/CustomAssets.txt"
$LogFile = Join-Path -Path $PSScriptRoot -ChildPath ("AssetCopyLog_{0}.log" -f (Get-Date -Format "ddMMyyyy_HHmmss"))

$SourceFolder = "" # If left empty, defaults to "$PSScriptRoot\Content"
$TargetFolder = "" # Can be set to a default path if needed, otherwise User will be prompted

# -------------------------
# FUNCTIONS
# -------------------------
function Write-Log {
  param(
    [string]$Message,
    [string]$Level = "INFO",
    [switch]$Silent  # Add a flag to skip console output
  )

  $timestamp = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
  $entry = "$timestamp [$Level] $Message"

  # Always write to log file
  Add-Content -Path $LogFile -Value $entry

  # Only display on console if not silent
  if (-not $Silent) {
    switch ($Level.ToUpper()) {
      "INFO" { Write-Host $entry -ForegroundColor Green }
      "WARN" { Write-Host $entry -ForegroundColor Yellow }
      "ERROR" { Write-Host $entry -ForegroundColor Red }
      "COPIED" { Write-Host $entry -ForegroundColor Cyan }
      "INVALIDPATH" { Write-Host $entry -ForegroundColor Magenta }
      default { Write-Host $entry }
    }

  }
}

function Write-Header {
  param([string]$Text)
  Write-Host "=== $Text ===" -ForegroundColor Magenta
}

function Write-Divider {
  Write-Host ("-" * 50) -ForegroundColor DarkGray
}

function Get-CustomAssets {
  $response = Invoke-WebRequest -Uri $CustomAssetListUrl -UseBasicParsing
  $lines = $response.Content -split "`n"

  $assets = @()
  # Define all substrings that indicate texture-like assets
  $skipKeywords = @('TX_', 'T_', 'TX2D_', '_Alb', '_Rough', '_Nor', '_Mask', '_Normal', '_Noise', 'Noise', 'DecalColor_', 'Decal_', 'NormalPack', 'Mask_Factory_02')

  foreach ($line in $lines) {
    $clean = ($line -replace "`r", "").Trim()
    if (-not $clean -or $clean -match '^\d{4}-\d{2}-\d{2}') { continue }

    # Normalize slashes
    $clean = $clean -replace '^[\\/]+', ''
    $clean = $clean -replace '/', '\'

    $baseName = [System.IO.Path]::GetFileName($clean)

    $skip = $false
    foreach ($kw in $skipKeywords) {
      if ($baseName -cmatch [regex]::Escape($kw)) {
        $skip = $true
        break
      }
    }

    if ($skip) {
      Write-Log "SKIPPED: $baseName (filtered by pattern)" "WARN"
      continue
    }

    $assets += $clean
  }
  return $assets
}


function Copy-Asset {
  param($Source, $Target)

  try {
    if (Test-Path $Source) {
      if (Test-Path $Source -PathType Container) {
        Copy-Item -Path $Source -Destination $Target -Recurse -Force
        Write-Log "Copied folder: $Source -> $Target"
      }
      else {
        Copy-Item -Path $Source -Destination $Target -Force
        Write-Log "Copied file: $Source -> $Target"
      }
    }
    else {
      Write-Log "Asset not found, skipping: $Source" "WARN"
    }
  }
  catch {
    Write-Log "Error copying $Source. Exception: $_" "WARN"
  }
}

# -------------------------
# MAIN
# -------------------------
Clear-Host
Write-Header "Unreal Asset Copy Tool"
Write-Host "This tool copies custom assets from a (backup) Starter Project into your generated project."
Write-Host "The Script should be placed in the root folder of your backup Starter Project, but its not mandatory."
Write-Divider
Write-Host "Press ENTER to continue..."
[void][System.Console]::ReadKey($true)

Clear-Host
Write-Header "'Asset Backup' and 'Dumped Content' Folders"
Write-Host "Please enter the full paths to the following folders:"
Write-Host "1. 'Asset Backup' folder: This is the Content folder from your (backup) Starter Project (where your original assets are stored)."
Write-Host "2. 'Dumped Content' folder: This is the Content folder of your generated or dumped project (where assets will be copied to)."
Write-Divider
Write-Host "ATTENTION: If you leave the 'Asset Backup' folder empty, it will default to your current folder `n'$PSScriptRoot\Content', `nwhich should be the correct path if you put the Script in the root folder of your (backup) Starter Project." -ForegroundColor Red
Write-Divider

$SourceFolder = Read-Host "Enter the path to your 'Asset Backup' folder [ex. $PSScriptRoot\Content]"
if (-not $SourceFolder) { $SourceFolder = Join-Path $PSScriptRoot "Content" }

# $SourceFolder = Read-Host "Enter/paste the path to your 'Asset Backup Content' folder (where you saved your Starter Project content)"
$TargetFolder = Read-Host "Enter the path to your 'Dumped Content' folder"

if (-not (Test-Path $SourceFolder)) {
  Write-Log "'Asset Backup' folder does not exist: $SourceFolder" "ERROR"
  exit
}
if (-not (Test-Path $TargetFolder)) {
  Write-Log "'Dumped Content' folder does not exist: $TargetFolder" "ERROR"
  exit
}

Write-Header "Starting copy process"
Write-Host "Copies the assets listed in the CustomAssets.txt from the 'Asset Backup' to the 'Dumped Content' folder."
Write-Divider
Write-Log "Asset Backup: $SourceFolder"
Write-Log "Dumped Content: $TargetFolder"
Write-Divider

# Get assets
$assets = Get-CustomAssets

# -------------------------
# Copy Assets with Bottom-Right Counter
# -------------------------

$width = [console]::WindowWidth
$height = [console]::WindowHeight

for ($index = 0; $index -lt $assets.Count; $index++) {
  $asset = $assets[$index]

  if ([string]::IsNullOrWhiteSpace($asset)) { continue }

  try {
    $srcPath = [System.IO.Path]::Combine($SourceFolder.TrimEnd('\'), $asset.Trim())
    $dstPath = [System.IO.Path]::Combine($TargetFolder.TrimEnd('\'), $asset.Trim())

    if ([string]::IsNullOrWhiteSpace($srcPath)) { continue }

    if (Test-Path $srcPath) {
      # Copy file/folder
      Copy-Item -Path $srcPath -Destination $dstPath -Recurse -Force

      # Log success
      Write-Log "COPIED: $asset ($srcPath -> $dstPath)" "COPIED"
    }
    else {
      # Log missing file
      Write-Log "MISSING: $asset ($srcPath) not found" "WARN"
    }
  }
  catch {
    Write-Log "INVALID PATH: $asset ($srcPath). Exception: $_" "WARN"
    continue
  }

  # -------------------------
  # Bottom-Right Progress Counter
  # -------------------------
  $counterText = "Processed: {0}/{1}" -f ($index + 1), $assets.Count
  [console]::SetCursorPosition([Math]::Max(0, $width - $counterText.Length), $height - 1)
  Write-Host $counterText -NoNewline -ForegroundColor Cyan
}


# Optional: copy StringTables
Write-Host "`n"
Write-Header "Copy Optional StringTables"
Write-Host "This tool can also copy StringTables from the backup folder."
Write-Divider
$includeStringTables = Read-Host "Do you also want to copy the StringTables folder? (y/n)"
if ($includeStringTables -match "^[Yy]") {
  $StringTablesSrc = Join-Path $SourceFolder "Localization/StringTables"
  $StringTablesDst = Join-Path $TargetFolder "Localization/StringTables"
  Copy-Asset -Source $StringTablesSrc -Target $StringTablesDst
}
else {
  Write-Log "Skipped copying StringTables"
}

# Build compact lists without touching log lines
$copiedFiles = $assets | Where-Object { Test-Path ([System.IO.Path]::Combine($SourceFolder, $_)) } |
ForEach-Object { [System.IO.Path]::GetFileName($_) }

$missingFiles = $assets | Where-Object { -not (Test-Path ([System.IO.Path]::Combine($SourceFolder, $_))) } |
ForEach-Object { [System.IO.Path]::GetFileName($_) }


Clear-Host
Write-Log "Process complete" -Silent
Write-Header "Copy Process Completed"
Write-Divider

Write-Host "Assets successfully copied ($($copiedFiles.Count)):`n" -ForegroundColor Cyan
$copiedFiles | ForEach-Object { Write-Host "- $_" -ForegroundColor Green }

Write-Host "`nAssets missing/skipped ($($missingFiles.Count)):`n" -ForegroundColor Yellow
$missingFiles | ForEach-Object { Write-Host "- $_" -ForegroundColor Yellow }

Write-Host "`nA log of this run has been saved to: $LogFile"
Write-Host "If you encounter issues, contact the author on the Satisfactory Modding Discord: rovetown."
Write-Divider

Write-Host "Press any key to exit..."
[void][System.Console]::ReadKey($true)

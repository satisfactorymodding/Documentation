import os
from pathlib import Path

def convert(filename):

    my_file = open("./txtp/" + filename, "r")
    data = my_file.read()

    data_into_list = data.replace('\n', ' ').split(" ")


    for i in range(len(data_into_list)):
        if data_into_list[i].startswith('wem'):

            wavname = "./txtp/" + data_into_list[i].split('.')[0] + '.wav'

            if os.path.isfile(wavname):
                os.rename(wavname, "./out/" + filename.split('.')[0] + '_' + str(i) + '.wav')
            else:
                print(wavname + " not found.")

    my_file.close()

relevant_path = "./txtp/"
included_extensions = ['txtp']
file_names = [fn for fn in os.listdir(relevant_path)
              if any(fn.endswith(ext) for ext in included_extensions)]


for file_name in file_names:
    convert(file_name)
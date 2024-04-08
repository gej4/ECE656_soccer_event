import os
import subprocess


folder_path = 'data'

for root, dirs, files in os.walk(folder_path):
    for file in files:
        if file.endswith('.csv'):
            file_path = os.path.join(root, file)
            sed_command = f"sed -i -e 's/,,/;;/g' -e 's/,\([^ ]\)/;\\1/g' '{file_path}'"
            print (f"Finish cleaning {file_path}")
            subprocess.run(sed_command, shell=True)

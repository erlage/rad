from dataclasses import replace
import os

def clear_folder(dir):
    if os.path.exists(dir):
        for the_file in os.listdir(dir):
            file_path = os.path.join(dir, the_file)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
                else:
                    clear_folder(file_path)
                    os.rmdir(file_path)
            except Exception as e:
                print(e)

def clean_file(file):
    if os.path.exists(file):
        if os.path.isfile(file):
            os.unlink(file)



def parse_test_from_template(template, replacements):
    default_replacements = [
        ('__Skip__', ''),
    ]

    with open(template, 'r') as file:
        contents = file.read()

        for key, value in replacements:
            contents = contents.replace(key, value)

        for key, value in default_replacements:
            contents = contents.replace(key, value)

        return contents
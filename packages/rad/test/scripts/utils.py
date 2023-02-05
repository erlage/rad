# Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

#!/usr/bin/env python3

import os
import re


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
    if os.path.exists(file) and os.path.isfile(file):
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


def convert_to_camel_case(name):
    pattern = re.compile(r'(?<!^)(?=[A-Z])')
    return pattern.sub('_', name).lower()

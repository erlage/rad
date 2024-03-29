# Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

#!/usr/bin/env python3

import os
import sys
from sys import argv

scripts_dir = os.path.abspath(os.path.dirname(__file__))
test_dir = os.path.abspath(os.path.join(scripts_dir, os.path.pardir))
rad_dir = os.path.abspath(os.path.join(test_dir, os.path.pardir))

import html_tests
import events_tests
import widgets_tests

def help():
    print('A small script for managing tests\n')
    print('Available commands: ')
    for cmd in sorted(commands.keys()):
        print('\t%s - %s' % (cmd, commands[cmd][1]))

    print('\nExample usage: py main.py gen\n')


def gen():
    html_tests.generate()
    events_tests.generate()
    widgets_tests.generate()


commands = {
    'gen': [gen, 'Re-generate all tests'],
}


def main():
    argv.pop(0)

    if not argv:
        help()

    while (argv):
        command = argv.pop(0)

        if not command in commands:
            help()
            break

        commands[command][0]()

if __name__ == '__main__':
    main()

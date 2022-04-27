
#!/usr/bin/env python3

import os
import sys
import html_tests
from sys import argv

scripts_dir = os.path.abspath(os.path.dirname(__file__))
test_dir = os.path.abspath(os.path.join(scripts_dir, os.path.pardir))
rad_dir = os.path.abspath(os.path.join(test_dir, os.path.pardir))


def help():
    print('A small script for managing tests\n')
    print('Available commands: ')
    for cmd in sorted(commands.keys()):
        print('\t%s - %s' % (cmd, commands[cmd][1]))

    print('\nExample usage: py main.py gen\n')


def gen():
    html_tests.generate()


commands = {
    'gen': [gen, 'Re-generate tests'],
}


def main():
    success = True
    argv.pop(0)

    if not argv:
        help()
        success = False

    while (argv):
        command = argv.pop(0)

        if not command in commands:
            help()
            success = False
            break

        returncode = commands[command][0]()
        success = success and not bool(returncode)

    sys.exit(not success)


if __name__ == '__main__':
    main()

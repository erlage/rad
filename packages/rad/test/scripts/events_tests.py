# Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

#!/usr/bin/env python3

import os
import re
import utils
import main

gen_folder = os.path.abspath(os.path.join(main.test_dir, 'tests', 'generated'))
widgets_folder = os.path.abspath(os.path.join(
    main.rad_dir, 'lib', 'src', 'widgets', 'html'))
templates_folder = os.path.abspath(
    os.path.join(main.test_dir, 'templates', 'events'))

skipped_tests = {}

event_specific_tests = {
    'onClick': [
        'event_propagate',
        'event_stop_propagate',
        'event_capture',
    ],
    'onDoubleClick': [
        'event_propagate',
        'event_stop_propagate',
        'event_capture',
    ],
    'onInput': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onChange': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onKeyUp': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onKeyDown': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onKeyPress': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onSubmit': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],

    # drag events

    'onDrag': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onDragEnd': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onDragEnter': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onDragLeave': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onDragOver': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onDragStart': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onDrop': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],

    # mouse events

    'onMouseDown': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onMouseEnter': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onMouseLeave': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onMouseMove': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onMouseOver': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onMouseOut': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
    'onMouseUp': [
        'event_not_propagate',
        'event_restart_propagate',
        'event_capture_with_restart',
    ],
}

global_tests = [
    'event_dispatch',
    'event_capture_basic',
]

events_map = {
    'onClick': 'click',
    'onDoubleClick': 'dblclick',
    'onInput': 'input',
    'onChange': 'change',
    'onSubmit': 'submit',
    'onKeyUp': 'keyup',
    'onKeyDown': 'keydown',
    'onKeyPress': 'keypress',

    # drag events

    'onDrag': 'drag',
    'onDragEnd': 'dragend',
    'onDragEnter': 'dragenter',
    'onDragLeave': 'dragleave',
    'onDragOver': 'dragover',
    'onDragStart': 'dragstart',
    'onDrop': 'drop',

    # mouse events

    'onMouseDown': 'mousedown',
    'onMouseEnter': 'mouseenter',
    'onMouseLeave': 'mouseleave',
    'onMouseMove': 'mousemove',
    'onMouseOver': 'mouseover',
    'onMouseOut': 'mouseout',
    'onMouseUp': 'mouseup',
}


def generate():
    invocations = ''
    part_of_directives = ''
    runner_file = os.path.abspath(os.path.join(
        main.test_dir, 'tests', 'generated', '_index_events_test.dart'))
    utils.clean_file(runner_file)

    for index, event_attr_name in enumerate(events_map):
        event_native_name = events_map[event_attr_name]

        event_attr_name_camel_case = utils.convert_to_camel_case(
            event_attr_name)

        out_file = os.path.abspath(os.path.join(
            main.test_dir, 'tests', 'generated', 'events', 'event_' + event_attr_name_camel_case + '_tests.generated.dart'))

        utils.clean_file(out_file)

        invocations += 'event_' + event_attr_name_camel_case + '_test();'

        part_of_directives += "part 'events/event_" + \
            event_attr_name_camel_case + "_tests.generated.dart';"

        generated = ''' 
            // Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
            // Use of this source code is governed by a BSD-style license that can be 
            // found in the LICENSE file.

            // Auto-generated file
            //
            // Sources of these tests can be found in /test/templates/events folder

            // ignore_for_file: non_constant_identifier_names

            part of '../_index_events_test.dart';

            void event_''' + event_attr_name_camel_case + '''_test() {

                group('Event ''' + event_attr_name + ''' (native: ''' + event_native_name + ''') tests:', () {
            
                    RT_AppRunner? app;

                    setUp(() {
                        app = createTestApp()..start();
                    });

                    tearDown(() => app!.stop());
            '''

        for test in global_tests:
            generated += '\n\n'

            replacements = [
                ('__EventAttributeName__', event_attr_name),
                ('__EventNativeName__', event_native_name),
            ]

            test_tpl = os.path.abspath(os.path.join(
                templates_folder, test + '.dart'))

            skip_context = ''
            if test in skipped_tests and event_native_name in skipped_tests[test]:
                skip_context = ', onPlatform: {'

                for platform in skipped_tests[test][event_native_name]:
                    skip_context += "'" + platform + \
                        "': Skip('Failing for " + event_native_name + \
                        " on " + platform + "'),"

                skip_context += '}'
                replacements.append(('__Skip__', skip_context))

            generated += utils.parse_test_from_template(
                test_tpl, replacements)

        # generate widget specific tests

        if event_attr_name in event_specific_tests:
            for test in event_specific_tests[event_attr_name]:
                generated += '\n\n'

                test_tpl = os.path.abspath(os.path.join(
                    templates_folder, test + '.dart'))

                generated += utils.parse_test_from_template(
                    test_tpl, replacements)

        generated += '}); \n\n }'

        os.makedirs(os.path.dirname(out_file), exist_ok=True)

        fh = open(out_file, 'w+')
        fh.write(generated)
        fh.close()

    runner_code = ''' 
        // Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
        // Use of this source code is governed by a BSD-style license that can be 
        // found in the LICENSE file.

        // Auto-generated file
        //
        // Sources of these tests can be found in /test/templates folder

        import '../../test_imports.dart';

        // fragments

        ''' + part_of_directives + '''

        void main() {

            ''' + invocations + '''

        }
        '''

    fh = open(runner_file, 'w+')
    fh.write(runner_code)
    fh.close()

    os.system('dart format ' + gen_folder)

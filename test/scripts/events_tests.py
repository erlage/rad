
#!/usr/bin/env python3

import os
import re
import utils
import main

gen_folder = os.path.abspath(os.path.join(main.test_dir, 'tests', 'generated'))
widgets_folder = os.path.abspath(os.path.join(
    main.rad_dir, 'lib', 'src', 'widgets', 'html'))
templates_folder = os.path.abspath(os.path.join(main.test_dir, 'templates', 'events'))

skipped_tests = {}

event_specific_tests = {
    'onClick': [
        'event_propagate',
        'event_stop_propagate',
    ],
    'onInput': [
        'event_not_propagate',
        'event_restart_propagate',
    ],
    'onChange': [
        'event_not_propagate',
        'event_restart_propagate',
    ],
    'onKeyUp': [
        'event_not_propagate',
        'event_restart_propagate',
    ],
    'onKeyDown': [
        'event_not_propagate',
        'event_restart_propagate',
    ],
    'onKeyPress': [
        'event_not_propagate',
        'event_restart_propagate',
    ],
    'onSubmit': [
        'event_not_propagate',
        'event_restart_propagate',
    ],
}

global_tests = [
    'event_dispatch',
]

events_map = {
    'onClick': 'click',
    'onInput': 'input',
    'onChange': 'change',
    'onKeyUp': 'keyup',
    'onKeyDown': 'keydown',
    'onKeyPress': 'keypress',
    'onSubmit': 'submit',
}


def generate():
    invokations = ''
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

        invokations += 'event_' + event_attr_name_camel_case + '_test();'

        part_of_directives += "part 'events/event_" + \
            event_attr_name_camel_case + "_tests.generated.dart';"

        generated = ''' 
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

            test_tmpl = os.path.abspath(os.path.join(
                templates_folder, test + '.dart.txt'))

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
                test_tmpl, replacements)

        # generate widget specific tests

        if event_attr_name in event_specific_tests:
            for test in event_specific_tests[event_attr_name]:
                generated += '\n\n'

                test_tmpl = os.path.abspath(os.path.join(
                    templates_folder, test + '.dart.txt'))

                generated += utils.parse_test_from_template(
                    test_tmpl, replacements)

        generated += '}); \n\n }'

        os.makedirs(os.path.dirname(out_file), exist_ok=True)

        fh = open(out_file, 'w+')
        fh.write(generated)
        fh.close()

    runner_code = ''' 
        // Auto-generated file
        //
        // Sources of these tests can be found in /test/templates folder

        import '../../test_imports.dart';

        // fragments

        ''' + part_of_directives + '''

        void main() {

            ''' + invokations + '''

        }
        '''

    fh = open(runner_file, 'w+')
    fh.write(runner_code)
    fh.close()

    os.system('dart format ' + gen_folder)

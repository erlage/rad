# Copyright (c) 2022, Rad developers. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

#!/usr/bin/env python3

import os
import re
import utils
import main
import glob

gen_folder = os.path.abspath(os.path.join(main.test_dir, 'tests', 'generated'))
widgets_folder = os.path.abspath(os.path.join(
    main.rad_dir, 'lib', 'src', 'widgets'))
templates_folder = os.path.abspath(os.path.join(main.test_dir, 'templates', 'widgets'))

# test-generation will(should) fail if a new widget is added without updating this file
# this is one of the reason we have this script, because there important tests
# like widget type override test that must be added for all widgets


no_tests_for = [
    'AsyncRoute',
    '_AsyncRoutePlaceholder',
    'FutureBuilder',
    'StreamBuilder',
    'ValueListenableBuilder',
    'Text',
    'InputText',
    'InputFile',
    'InputRadio',
    'InputSubmit',
    'InputCheckBox',
]

widget_specific_tests = {
    'RadApp': ['widget_specific_rad_app'],
    'Route': ['widget_specific_route'],
    'RawMarkUp': ['widget_specific_raw_mark_up'],
    'ListView': ['widget_specific_list_view'],
    'Navigator': ['widget_specific_navigator'],
    'EventDetector': ['widget_specific_event_detector'],

    'InheritedWidget': ['widget_specific_inherited_widget'],
    'StatelessWidget': ['widget_specific_stateless_widget'],
    'StatefulWidget': ['widget_specific_stateful_widget'],
    'GestureDetector': ['widget_specific_gesture_detector_widget'],

    # html,

    'Address': ['widget_specific_html_widgets'],
    'Abbreviation': ['widget_specific_html_widgets'],
    'Anchor': ['widget_specific_html_widgets'],
    'Article': ['widget_specific_html_widgets'],
    'Aside': ['widget_specific_html_widgets'],
    'BidirectionalIsolate': ['widget_specific_html_widgets'],
    'BidirectionalTextOverride': ['widget_specific_html_widgets'],
    'BlockQuote': ['widget_specific_html_widgets'],
    'BreakLine': ['widget_specific_html_widgets'],
    'Button': ['widget_specific_html_widgets'],
    'Canvas': ['widget_specific_html_widgets'],
    'Caption': ['widget_specific_html_widgets'],
    'Code': ['widget_specific_html_widgets'],
    'DescriptionDetails': ['widget_specific_html_widgets'],
    'DescriptionList': ['widget_specific_html_widgets'],
    'DescriptionTerm': ['widget_specific_html_widgets'],
    'Division': ['widget_specific_html_widgets'],
    'FieldSet': ['widget_specific_html_widgets'],
    'Figure': ['widget_specific_html_widgets'],
    'FigureCaption': ['widget_specific_html_widgets'],
    'Footer': ['widget_specific_html_widgets'],
    'Form': ['widget_specific_html_widgets'],
    'Heading1': ['widget_specific_html_widgets'],
    'Heading2': ['widget_specific_html_widgets'],
    'Heading3': ['widget_specific_html_widgets'],
    'Heading4': ['widget_specific_html_widgets'],
    'Heading5': ['widget_specific_html_widgets'],
    'Heading6': ['widget_specific_html_widgets'],
    'Header': ['widget_specific_html_widgets'],
    'HorizontalRule': ['widget_specific_html_widgets'],
    'IFrame': ['widget_specific_html_widgets'],
    'Idiomatic': ['widget_specific_html_widgets'],
    'Image': ['widget_specific_html_widgets'],
    'Input': ['widget_specific_html_widgets'],
    'Label': ['widget_specific_html_widgets'],
    'Legend': ['widget_specific_html_widgets'],
    'ListItem': ['widget_specific_html_widgets'],
    'Menu': ['widget_specific_html_widgets'],
    'Navigation': ['widget_specific_html_widgets'],
    'OrderedList': ['widget_specific_html_widgets'],
    'Option': ['widget_specific_html_widgets'],
    'Paragraph': ['widget_specific_html_widgets'],
    'PreformattedText': ['widget_specific_html_widgets'],
    'Progress': ['widget_specific_html_widgets'],
    'Select': ['widget_specific_html_widgets'],
    'Small': ['widget_specific_html_widgets'],
    'Span': ['widget_specific_html_widgets'],
    'StrikeThrough': ['widget_specific_html_widgets'],
    'Strong': ['widget_specific_html_widgets'],
    'SubScript': ['widget_specific_html_widgets'],
    'SuperScript': ['widget_specific_html_widgets'],
    'Table': ['widget_specific_html_widgets'],
    'TableBody': ['widget_specific_html_widgets'],
    'TableColumn': ['widget_specific_html_widgets'],
    'TableColumnGroup': ['widget_specific_html_widgets'],
    'TableDataCell': ['widget_specific_html_widgets'],
    'TableFoot': ['widget_specific_html_widgets'],
    'TableHead': ['widget_specific_html_widgets'],
    'TableHeaderCell': ['widget_specific_html_widgets'],
    'TableRow': ['widget_specific_html_widgets'],
    'TextArea': ['widget_specific_html_widgets'],
    'UnOrderedList': ['widget_specific_html_widgets'],
}

widgets_pattern = re.compile(r'^class ([\w]*) extends (Widget|MarkUpTagWithGlobalProps|Input|Span|Division|TableCellBase|TableColumnBase) {', re.M)

def checkWidgets():
    files = glob.glob(widgets_folder + '/**/*.dart', recursive=True)

    for file in files:
        with open(file, 'r') as file:
            contents = file.read()
        
            results = widgets_pattern.findall(contents)

            for match in results:

                widget_name = match[0]

                if widget_name not in no_tests_for and widget_name not in widget_specific_tests:
                    print(bcolors.FAIL + f"Warning: There might be missing tests for {widget_name} widget" + bcolors.ENDC)
                    raise 'Missing widget entry, please refer to widget_tests.py for fixing this problem'

def generate():
    checkWidgets()

    invokations = ''
    part_of_directives = ''

    runner_file = os.path.abspath(os.path.join(
        main.test_dir, 'tests', 'generated', '_index_widgets_test.dart'))
    utils.clean_file(runner_file)

    for index, widget_class_name in enumerate(widget_specific_tests):
        if widget_specific_tests in no_tests_for:
            continue

        tests = widget_specific_tests[widget_class_name]

        widget_class_name_camel_case = utils.convert_to_camel_case(
            widget_class_name)

        out_file = os.path.abspath(os.path.join(
            main.test_dir, 'tests', 'generated', 'widgets', 'widget_' + widget_class_name_camel_case + '_tests.generated.dart'))

        utils.clean_file(out_file)

        invokations += 'widget_' + widget_class_name_camel_case + '_test();'

        part_of_directives += "part 'widgets/widget_" + \
            widget_class_name_camel_case + "_tests.generated.dart';"

        generated = ''' 
            // Copyright (c) 2022, Rad developers. All rights reserved.
            // Use of this source code is governed by a BSD-style license that can be 
            // found in the LICENSE file.

            // Auto-generated file
            //
            // Sources of these tests can be found in /test/templates folder

            // ignore_for_file: non_constant_identifier_names

            part of '../_index_widgets_test.dart';

            void widget_''' + widget_class_name_camel_case + '''_test() {

                group('Widget specific tests for ''' + widget_class_name + ''' widget:', () {
            
                    RT_AppRunner? app;

                    setUp(() {
                        app = createTestApp()..start();
                    });

                    tearDown(() => app!.stop());
            '''

        for test in tests:
            generated += '\n\n'

            replacements = [
                ('__WidgetClass__', widget_class_name),
            ]

            test_tmpl = os.path.abspath(os.path.join(
                templates_folder, test + '.dart'))

            generated += utils.parse_test_from_template(
                test_tmpl, replacements)

        generated += '}); \n\n }'

        os.makedirs(os.path.dirname(out_file), exist_ok=True)

        fh = open(out_file, 'w+')
        fh.write(generated)
        fh.close()

    runner_code = ''' 
        // Copyright (c) 2022, Rad developers. All rights reserved.
        // Use of this source code is governed by a BSD-style license that can be 
        // found in the LICENSE file.

        // Auto-generated file
        //
        // Sources of these tests can be found in /test/templates/html folder

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

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

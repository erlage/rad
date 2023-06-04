# Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
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
    'RadApp',
    'RawMarkUp',
    'ListView',

    'AsyncRoute',
    '_AsyncRoutePlaceholder',
    '_AsyncRouteBuilder',
    'FutureBuilder',
    'StreamBuilder',
    'ValueListenableBuilder',
    'RawEventDetector',
    'RenderScope',
    'Text',
    
    # html additional
    
    'InputCheckBox',
    'InputFile',
    'InputRadio',
    'InputSubmit',
    'InputText',

    # html main

    'Abbreviation',
    'Address',
    'Anchor',
    'Article',
    'Aside',
    'Audio',
    'BidirectionalIsolate',
    'BidirectionalTextOverride',
    'BlockQuote',
    'LineBreak',
    'Button',
    'Canvas',
    'TableCaption',
    'Citation',
    'InlineCode',
    'Data',
    'DataList',
    'Definition',
    'DeletedText',
    'DescriptionDetails',
    'DescriptionList',
    'DescriptionTerm',
    'Details',
    'Dialog',
    'Division',
    'EmbedExternal',
    'EmbedTextTrack',
    'Emphasis',
    'FieldSet',
    'Figure',
    'FigureCaption',
    'Footer',
    'Form',
    'Header',
    'Heading1',
    'Heading2',
    'Heading3',
    'Heading4',
    'Heading5',
    'Heading6',
    'HorizontalRule',
    'Idiomatic',
    'IFrame',
    'Image',
    'ImageMap',
    'ImageMapArea',
    'InlineQuotation',
    'Input',
    'InsertedText',
    'KeyboardInput',
    'Label',
    'Legend',
    'LineBreakOpportunity',
    'ListItem',
    'MarkText',
    'MediaSource',
    'Menu',
    'Meter',
    'Navigation',
    'Option',
    'OptionGroup',
    'OrderedList',
    'Output',
    'Paragraph',
    'Picture',
    'Portal',
    'PreformattedText',
    'Progress',
    'RubyAnnotation',
    'RubyFallbackParenthesis',
    'RubyText',
    'SampleOutput',
    'Section',
    'Select',
    'Small',
    'Span',
    'StrikeThrough',
    'Strong',
    'SubScript',
    'Summary',
    'SuperScript',
    'Table',
    'TableBody',
    'TableColumn',
    'TableColumnGroup',
    'TableDataCell',
    'TableFoot',
    'TableHead',
    'TableHeaderCell',
    'TableRow',
    'TextArea',
    'Time',
    'UnOrderedList',
    'Variable',
    'Video',
]

widget_specific_tests = {
    'Route': ['widget_specific_route'],
    'Navigator': ['widget_specific_navigator'],
    'EventDetector': ['widget_specific_event_detector'],

    'InheritedWidget': ['widget_specific_inherited_widget'],
    'StatelessWidget': ['widget_specific_stateless_widget'],
    'StatefulWidget': ['widget_specific_stateful_widget'],
    'GestureDetector': ['widget_specific_gesture_detector_widget'],
}

widgets_pattern = re.compile(r'^class ([\w]*) extends (Widget|Input|Span|Division|HTMLWidgetBase|HTMLTableCellBase|HTMLTableColumnBase|HTMLBidirectionalBase|StatefulWidget|StatelessWidget) {', re.M)

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

    invocations = ''
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

        invocations += 'widget_' + widget_class_name_camel_case + '_test();'

        part_of_directives += "part 'widgets/widget_" + \
            widget_class_name_camel_case + "_tests.generated.dart';"

        generated = ''' 
            // Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
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
        // Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
        // Use of this source code is governed by a BSD-style license that can be 
        // found in the LICENSE file.

        // Auto-generated file
        //
        // Sources of these tests can be found in /test/templates/html folder

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

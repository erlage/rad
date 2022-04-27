
#!/usr/bin/env python3

import os
import utils
import main

gen_folder = os.path.abspath(os.path.join(main.test_dir, 'tests', 'generated'))
widgets_folder = os.path.abspath(os.path.join(
    main.rad_dir, 'lib', 'src', 'widgets', 'html'))
templates_folder = os.path.abspath(os.path.join(main.test_dir, 'templates'))

skipped_tests = {
    'html_attr_innertext': {
        'img': ['chrome']
    }
}

tests = [
    'html_attr_child',
    'html_attr_children',
    'html_attr_classes',
    'html_attr_contenteditable',
    'html_attr_draggable',
    'html_attr_hidden',
    'html_attr_innertext',
    'html_attr_onclick',
    'html_attr_style',
    'html_attr_tabindex',
    'html_attr_title',
    'html_internal_markup',
    'widget_key',
]

widgets_map = {
    'iframe': 'IFrame',
    'a': 'Anchor',
    'small': 'Small',
    'h1': 'Heading1',
    'h2': 'Heading2',
    'h3': 'Heading3',
    'h4': 'Heading4',
    'h5': 'Heading5',
    'h6': 'Heading6',
    'span': 'Span',
    'div': 'Division',
    'i': 'Idiomatic',
    'nav': 'Navigation',
    'select': 'Select',
    'ul': 'UnOrderedList',
    'canvas': 'Canvas',
    'header': 'Header',
    'legend': 'Legend',
    'footer': 'Footer',
    'strong': 'Strong',
    'textarea': 'TextArea',
    'li': 'ListItem',
    'sup': 'SuperScript',
    'blockquote': 'Blockquote',
    'option': 'Option',
    'p': 'Paragraph',
    'sub': 'SubScript',
    'form': 'Form',
    'progress': 'Progress',
    'img': 'Image',
    'fieldset': 'FieldSet',
    'label': 'Label',
    'button': 'Button',
}


def generate():
    invokations = ''
    part_of_directives = ''
    runner_file = os.path.abspath(os.path.join(
        main.test_dir, 'tests', 'generated', '_html_tests_index_test.dart'))
    utils.clean_file(runner_file)

    for index, widget_tag in enumerate(widgets_map):
        out_file = os.path.abspath(os.path.join(
            main.test_dir, 'tests', 'generated', 'html_' + widget_tag + '_tests.generated.dart'))

        utils.clean_file(out_file)

        invokations += 'html_' + widget_tag + '_test();'

        part_of_directives += "part 'html_" + widget_tag + "_tests.generated.dart';"

        generated = ''' 
            // Auto-generated file
            //
            // Sources of these tests can be found in /test/templates folder

            // ignore_for_file: non_constant_identifier_names

            part of '_html_tests_index_test.dart';

            void html_''' + widget_tag + '''_test() {

                group('HTML ''' + widgets_map[widget_tag] + ''' tests:', () {
            
                    RT_AppRunner? app;

                    setUp(() {
                        app = createTestApp()..start();
                    });

                    tearDown(() => app!.stop());
            '''

        for test in tests:
            generated += '\n\n'

            test_tmpl = os.path.abspath(os.path.join(
                templates_folder, test + '.tests.tpl'))

            replacements = [
                ('__WidgetClass__', widgets_map[widget_tag]),
                ('__WidgetTag__', widget_tag),
            ]

            skip_context = ''
            if test in skipped_tests and widget_tag in skipped_tests[test]:
                skip_context = ', onPlatform: {'

                for platform in skipped_tests[test][widget_tag]:
                    skip_context += "'" + platform + \
                        "': Skip('Failing for " + widget_tag + \
                        " on " + platform + "'),"

                skip_context += '}'
                replacements.append(('__Skip__', skip_context))

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

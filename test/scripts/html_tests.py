
#!/usr/bin/env python3

import os
import re
import utils
import main

gen_folder = os.path.abspath(os.path.join(main.test_dir, 'tests', 'generated'))
widgets_folder = os.path.abspath(os.path.join(
    main.rad_dir, 'lib', 'src', 'widgets', 'html'))
templates_folder = os.path.abspath(os.path.join(main.test_dir, 'templates'))

skipped_tests = {
    'html_attr_innertext': {
        'img': ['chrome'],    # works on firefox
        'col': ['chrome'],    # works on firefox
        'br': ['chrome'],     # works on firefox
        'hr': ['chrome'],     # works on firefox
        'input': ['chrome'],  # works on firefox
    },
}

tag_specific_tests = {
    'a': [
        'html_attr_href',
        'html_attr_rel',
        'html_attr_target',
        'html_attr_download',
    ],
    'blockquote': [
        'html_attr_cite',
    ],
    'button': [
        'html_attr_name',
        'html_attr_value',
        'html_attr_disabled',
        'html_attr_button_type',
    ],
    'fieldset': [
        'html_attr_disabled',
    ],
}

global_tests = [
    'html_attr_id',
    'html_attr_child',
    'html_attr_children',
    'html_attr_classes',
    'html_attr_contenteditable',
    'html_attr_draggable',
    'html_attr_hidden',
    'html_attr_innertext',
    'html_attr_onclick',
    'html_attr_onclick_event_listener',
    'html_attr_style',
    'html_attr_tabindex',
    'html_attr_title',
    'html_internal_markup',
    'html_attr_dataset',
    'widget_key',
]


widgets_map = {
    'Abbreviation': 'abbr',
    'Anchor': 'a',
    'Article': 'article',
    'Blockquote': 'blockquote',
    'BreakLine': 'br',
    'Button': 'button',
    'Canvas': 'canvas',
    'Caption': 'caption',
    'Code': 'code',
    'Division': 'div',
    'FieldSet': 'fieldset',
    'Footer': 'footer',
    'Form': 'form',
    'Heading1': 'h1',
    'Heading2': 'h2',
    'Heading3': 'h3',
    'Heading4': 'h4',
    'Heading5': 'h5',
    'Heading6': 'h6',
    'Header': 'header',
    'HorizontalRule': 'hr',
    'IFrame': 'iframe',
    'Idiomatic': 'i',
    'Image': 'img',
    'InputCheckBox': 'input',
    'InputFile': 'input',
    'InputRadio': 'input',
    'InputSubmit': 'input',
    'InputText': 'input',
    'Label': 'label',
    'Legend': 'legend',
    'ListItem': 'li',
    'Menu': 'menu',
    'Navigation': 'nav',
    'Option': 'option',
    'Paragraph': 'p',
    'Progress': 'progress',
    'Select': 'select',
    'Small': 'small',
    'Span': 'span',
    'StrikeThrough': 's',
    'Strong': 'strong',
    'SubScript': 'sub',
    'SuperScript': 'sup',
    'Table': 'table',
    'TableColumn': 'col',
    'TableColumnGroup': 'colgroup',
    'TableDataCell': 'td',
    'TableFoot': 'tfoot',
    'TableHead': 'thead',
    'TableHeaderCell': 'th',
    'TableRow': 'tr',
    'TextArea': 'textarea',
    'UnOrderedList': 'ul',
}


def generate():
    invokations = ''
    part_of_directives = ''
    runner_file = os.path.abspath(os.path.join(
        main.test_dir, 'tests', 'generated', '_html_tests_index_test.dart'))
    utils.clean_file(runner_file)

    for index, widget_class_name in enumerate(widgets_map):
        widget_tag = widgets_map[widget_class_name]

        widget_class_name_camel_case = utils.convert_to_camel_case(
            widget_class_name)

        out_file = os.path.abspath(os.path.join(
            main.test_dir, 'tests', 'generated', 'html_' + widget_class_name_camel_case + '_tests.generated.dart'))

        utils.clean_file(out_file)

        invokations += 'html_' + widget_class_name_camel_case + '_test();'

        part_of_directives += "part 'html_" + \
            widget_class_name_camel_case + "_tests.generated.dart';"

        generated = ''' 
            // Auto-generated file
            //
            // Sources of these tests can be found in /test/templates folder

            // ignore_for_file: non_constant_identifier_names

            part of '_html_tests_index_test.dart';

            void html_''' + widget_class_name_camel_case + '''_test() {

                group('HTML ''' + widget_class_name + ''' tests:', () {
            
                    RT_AppRunner? app;

                    setUp(() {
                        app = createTestApp()..start();
                    });

                    tearDown(() => app!.stop());
            '''

   

        for test in global_tests:
            generated += '\n\n'

            replacements = [
                    ('__WidgetClass__', widget_class_name),
                    ('__WidgetTag__', widget_tag),
                ]

            test_tmpl = os.path.abspath(os.path.join(
                templates_folder, test + '.dart.txt'))

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


        # generate widget specific tests

        if widget_tag in tag_specific_tests:
            for test in tag_specific_tests[widget_tag]:
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

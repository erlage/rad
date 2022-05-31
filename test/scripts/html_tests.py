
#!/usr/bin/env python3

import os
import re
import utils
import main

gen_folder = os.path.abspath(os.path.join(main.test_dir, 'tests', 'generated'))
widgets_folder = os.path.abspath(os.path.join(
    main.rad_dir, 'lib', 'src', 'widgets', 'html'))
templates_folder = os.path.abspath(
    os.path.join(main.test_dir, 'templates', 'html'))

skipped_tests = {
    'html_attr_innertext': {
        'img': ['chrome'],    # works on firefox
        'col': ['chrome'],    # works on firefox
        'br': ['chrome'],     # works on firefox
        'hr': ['chrome'],     # works on firefox
        'input': ['chrome'],  # works on firefox
    }
}

skipped_generation_for_class = {
    'html_short_tag': [
        'InputCheckBox',
        'InputFile',
        'InputRadio',
        'InputSubmit',
        'InputText',
    ]
}

widget_specific_tests = {
    'Anchor': [
        'html_attr_href',
        'html_attr_rel',
        'html_attr_target',
        'html_attr_download',
    ],
    'Blockquote': [
        'html_attr_cite',
    ],
    'Button': [
        'html_attr_name',
        'html_attr_value',
        'html_attr_disabled',
        'html_attr_button_type',
    ],
    'FieldSet': [
        'html_attr_disabled',
    ],
    'Form': [
        'html_attr_name',
        'html_attr_action',
        'html_attr_accept',
        'html_attr_target',
        'html_attr_form_method',
        'html_attr_form_enctype',
    ],
    'IFrame': [
        'html_attr_name',
        'html_attr_allow',
        'html_attr_src',
        'html_attr_width',
        'html_attr_height',
        'html_attr_allowfullscreen',
        'html_attr_allowpaymentrequest',
    ],
    'Image': [
        'html_attr_src',
        'html_attr_alt',
        'html_attr_width',
        'html_attr_height',
    ],
    'Input': [
        'html_attr_name',
        'html_attr_value',
        'html_attr_accept',
        'html_attr_minlength',
        'html_attr_maxlength',
        'html_attr_pattern',
        'html_attr_placeholder',
        'html_attr_multiple',
        'html_attr_required',
        'html_attr_readonly',
        'html_attr_disabled',
        'html_attr_checked',
        'html_attr_input_type',
        'html_attr_on_change',
        'html_attr_on_input',
        'html_attr_on_key_press',
        'html_attr_on_key_up',
        'html_attr_on_key_down',
    ],
    'Label': [
        'html_attr_for_attribute',
    ],
    'ListItem': [
        'html_attr_value_int',
    ],
    'Option': [
        'html_attr_label',
        'html_attr_value',
        'html_attr_selected',
        'html_attr_disabled',
    ],
    'Progress': [
        'html_attr_value_num',
        'html_attr_max',
    ],
    'Select': [
        'html_attr_name',
        'html_attr_multiple',
        'html_attr_disabled',
    ],
    'TableColumnGroup': [
        'html_attr_span',
    ],
    'TableColumn': [
        'html_attr_span',
    ],
    'TableDataCell': [
        'html_attr_rowspan',
        'html_attr_colspan',
        'html_attr_headers',
    ],
    'TableHeaderCell': [
        'html_attr_rowspan',
        'html_attr_colspan',
        'html_attr_headers',
    ],
    'TextArea': [
        'html_attr_name',
        'html_attr_placeholder',
        'html_attr_rows',
        'html_attr_cols',
        'html_attr_minlength',
        'html_attr_maxlength',
        'html_attr_required',
        'html_attr_readonly',
        'html_attr_disabled',
    ],

    # additional

    'InputText': [
        'html_attr_name',
        'html_attr_value',
        'html_attr_minlength',
        'html_attr_maxlength',
        'html_attr_pattern',
        'html_attr_placeholder',
        'html_attr_required',
        'html_attr_readonly',
        'html_attr_disabled',
        'html_input_text_is_password',
        'html_attr_on_change',
        'html_attr_on_input',
        'html_attr_on_key_press',
        'html_attr_on_key_up',
        'html_attr_on_key_down',
    ],
    'InputCheckBox': [
        'html_attr_name',
        'html_attr_value',
        'html_attr_required',
        'html_attr_disabled',
        'html_attr_checked',
        'html_attr_on_change',
    ],
    'InputRadio': [
        'html_attr_name',
        'html_attr_value',
        'html_attr_required',
        'html_attr_disabled',
        'html_attr_checked',
        'html_attr_on_change',
    ],
    'InputFile': [
        'html_attr_name',
        'html_attr_accept',
        'html_attr_multiple',
        'html_attr_required',
        'html_attr_disabled',
        'html_attr_on_change',
    ],
    'InputSubmit': [
        'html_attr_name',
        'html_attr_value',
        'html_attr_required',
        'html_attr_disabled',
    ],
}

global_tests = [
    'html_attr_id',
    'html_attr_child',
    'html_attr_children',
    'html_attr_class_attribute',
    'html_attr_contenteditable',
    'html_attr_draggable',
    'html_attr_hidden',
    'html_attr_innertext',
    'html_attr_on_click_attribute',
    'html_attr_on_click',
    'html_attr_style',
    'html_attr_tabindex',
    'html_attr_title',
    'html_internal_markup',
    'html_attr_dataset',
    'html_short_tag',
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
    'Input': 'input',
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
    'TableBody': 'tbody',
    'TableColumn': 'col',
    'TableColumnGroup': 'colgroup',
    'TableDataCell': 'td',
    'TableFoot': 'tfoot',
    'TableHead': 'thead',
    'TableHeaderCell': 'th',
    'TableRow': 'tr',
    'TextArea': 'textarea',
    'UnOrderedList': 'ul',

    # additionals,

    'InputCheckBox': 'input',
    'InputFile': 'input',
    'InputRadio': 'input',
    'InputSubmit': 'input',
    'InputText': 'input',
}


def generate():
    invokations = ''
    part_of_directives = ''
    runner_file = os.path.abspath(os.path.join(
        main.test_dir, 'tests', 'generated', '_index_html_test.dart'))
    utils.clean_file(runner_file)

    for index, widget_class_name in enumerate(widgets_map):
        widget_tag = widgets_map[widget_class_name]

        widget_class_name_camel_case = utils.convert_to_camel_case(
            widget_class_name)

        out_file = os.path.abspath(os.path.join(
            main.test_dir, 'tests', 'generated', 'html', 'html_' + widget_class_name_camel_case + '_tests.generated.dart'))

        utils.clean_file(out_file)

        invokations += 'html_' + widget_class_name_camel_case + '_test();'

        part_of_directives += "part 'html/html_" + \
            widget_class_name_camel_case + "_tests.generated.dart';"

        generated = ''' 
            // Auto-generated file
            //
            // Sources of these tests can be found in /test/templates folder

            // ignore_for_file: non_constant_identifier_names

            part of '../_index_html_test.dart';

            void html_''' + widget_class_name_camel_case + '''_test() {

                group('HTML ''' + widget_class_name + ''' tests:', () {
            
                    RT_AppRunner? app;

                    setUp(() {
                        app = createTestApp()..start();
                    });

                    tearDown(() => app!.stop());
            '''

        for test in global_tests:
            
            if test in skipped_generation_for_class:
                skipable_for = skipped_generation_for_class[test]
                if widget_class_name in skipable_for:
                    continue

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

        if widget_class_name in widget_specific_tests:
            for test in widget_specific_tests[widget_class_name]:
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

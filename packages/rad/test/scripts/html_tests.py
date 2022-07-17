# Copyright (c) 2022, Rad developers. All rights reserved.
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
    os.path.join(main.test_dir, 'templates', 'html'))

skipped_tests = {
    'html_attr_innertext': {
        'area':     ['chrome'], 
        'img':      ['chrome'],  
        'col':      ['chrome'],  
        'br':       ['chrome'],   
        'wbr':      ['chrome'],  
        'hr':       ['chrome'],   
        'input':    ['chrome'],
        'track':    ['chrome'],
        'embed':    ['chrome'],
        'source':    ['chrome'],
    }
}

skipped_generation_for_class = {
    'html_short_tag': [
        'Variable',           # var is a reserved keyword in dart
        'InputButton',
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
        'html_attr_hreflang',
        'html_attr_ping',
        'html_attr_referrer_policy',
        'html_attr_rel',
        'html_attr_target',
        'html_attr_download',
        'html_attr_type_string',
    ],
    'Audio': [
        'html_attr_autoplay',
        'html_attr_controls',
        'html_attr_cross_origin_type',
        'html_attr_loop',
        'html_attr_muted',
        'html_attr_preload_type',
        'html_attr_src',
    ],
    'BidirectionalIsolate': [
        'html_attr_dir',
    ],
    'BidirectionalTextOverride': [
        'html_attr_dir',
    ],    
    'BlockQuote': [
        'html_attr_cite',
    ],
    'Button': [
        'html_attr_name',
        'html_attr_value',
        'html_attr_disabled',
        'html_attr_button_type',
        'html_attr_form',
        'html_attr_form_action',
        'html_attr_form_enctype',
        'html_attr_form_method',
        'html_attr_form_target',
        'html_attr_form_no_validate',
    ],
    'Canvas': [
        'html_attr_height',
        'html_attr_width',
    ],
    'Data': [
        'html_attr_value',
    ],
    'DeletedText': [
        'html_attr_cite',
        'html_attr_datetime',
    ],
    'Details': [
        'html_attr_open'
    ],
    'Dialog': [
        'html_attr_open'
    ],
    'EmbedExternal': [
        'html_attr_width',
        'html_attr_src',
        'html_attr_type_string',
        'html_attr_height',
    ],
    'EmbedTextTrack': [
        'html_attr_default_attribute',
        'html_attr_kind_type',
        'html_attr_label',
        'html_attr_src',
        'html_attr_srclang',
    ],
    'FieldSet': [
        'html_attr_name',
        'html_attr_form',
        'html_attr_disabled',
    ],
    'Form': [
        'html_attr_name',
        'html_attr_action',
        'html_attr_accept_charset',
        'html_attr_auto_complete',
        'html_attr_rel',
        'html_attr_target',
        'html_attr_method',
        'html_attr_enctype',
        'html_attr_no_validate',
        'html_attr_on_submit',
    ],
    'IFrame': [
        'html_attr_name',
        'html_attr_allow',
        'html_attr_src',
        'html_attr_src_doc',
        'html_attr_width',
        'html_attr_height',
        'html_attr_allowfullscreen',
        'html_attr_allowpaymentrequest',
        'html_attr_fetch_priority',
        'html_attr_referrer_policy',
    ],
    'Image': [
        'html_attr_src',
        'html_attr_alt',
        'html_attr_cross_origin_type',
        'html_attr_decoding',
        'html_attr_fetch_priority',
        'html_attr_loading',
        'html_attr_referrer_policy',
        'html_attr_src_set',
        'html_attr_width',
        'html_attr_height',
    ],
    'ImageMap': [
        'html_attr_name',
    ],
    'ImageMapArea': [
        'html_attr_alt',
        'html_attr_coords',
        'html_attr_href',
        'html_attr_hreflang',
        'html_attr_download',
        'html_attr_ping',
        'html_attr_referrer_policy',
        'html_attr_rel',
        'html_attr_shape',
        'html_attr_target',
    ],
    'InlineQuotation': [
        'html_attr_cite',
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
    'InsertedText': [
        'html_attr_cite',
        'html_attr_datetime',
    ],
    'Label': [
        'html_attr_for_attribute',
    ],
    'ListItem': [
        'html_attr_value_int',
    ],
    'MediaSource': [
        'html_attr_type_string',
        'html_attr_src',
        'html_attr_src_set',
        'html_attr_sizes',
        'html_attr_media',
        'html_attr_height',
        'html_attr_width',
    ],
    'Meter': [
        'html_attr_value_int',
        'html_attr_max',
        'html_attr_min',
        'html_attr_high',
        'html_attr_low',
        'html_attr_optimum',
    ],
    'OrderedList': [
        'html_attr_start',
        'html_attr_reversed',
        'html_attr_list_type',
    ],
    'Option': [
        'html_attr_label',
        'html_attr_value',
        'html_attr_selected',
        'html_attr_disabled',
    ],
    'OptionGroup': [
        'html_attr_label',
        'html_attr_disabled',
    ],
    'Output': [
        'html_attr_name',
        'html_attr_form',
        'html_attr_for_attribute',
    ],
    'Portal': [
        'html_attr_referrer_policy',
        'html_attr_src',
    ],
    'Progress': [
        'html_attr_value_num',
        'html_attr_max',
    ],
    'Select': [
        'html_attr_name',
        'html_attr_multiple',
        'html_attr_disabled',
        'html_attr_on_change',
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
        'html_attr_on_change',
        'html_attr_on_input',
        'html_attr_on_key_press',
        'html_attr_on_key_up',
        'html_attr_on_key_down',
        'html_prop_value',
    ],
    'Time': [
        'html_attr_datetime',
    ],
    'Video': [
        'html_attr_autoplay',
        'html_attr_controls',
        'html_attr_cross_origin_type',
        'html_attr_height',
        'html_attr_loop',
        'html_attr_muted',
        'html_attr_playsinline',
        'html_attr_poster',
        'html_attr_preload_type',
        'html_attr_src',
        'html_attr_width',
    ],

    # additional

    'InputButton': [
        'html_attr_name',
        'html_attr_disabled',
        'html_attr_form',
        'html_attr_input_mode',
        'html_attr_tabindex',
        'html_attr_value',
    ],
    'InputCheckBox': [
        'html_attr_checked',
        'html_attr_required',
        'html_attr_on_change',

        'html_attr_name',
        'html_attr_disabled',
        'html_attr_form',
        'html_attr_input_mode',
        'html_attr_tabindex',
        'html_attr_value',
    ],
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
    'InputRadio': [
        'html_attr_name',
        'html_attr_value',
        'html_attr_required',
        'html_attr_disabled',
        'html_attr_checked',
        'html_attr_on_change',
    ],
    'InputFile': [
        'html_attr_accept',
        'html_attr_auto_complete',
        'html_attr_capture',
        'html_attr_list',
        'html_attr_multiple',
        'html_attr_readonly',
        'html_attr_on_change',

        'html_attr_name',
        'html_attr_disabled',
        'html_attr_form',
        'html_attr_input_mode',
        'html_attr_tabindex',
        'html_attr_value',
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
    'html_attr_children',
    'html_attr_child',
    'html_attr_class_name',
    'html_attr_hidden',
    'html_attr_innertext',
    'html_attr_on_click',
    'html_attr_style',
    'html_attr_title',
    'html_internal_markup',
    'html_attr_additional_attributes',
    'html_short_tag',
    'widget_key',
]


widgets_map = {
    'Abbreviation': 'abbr',
    'Address': 'address',
    'Anchor': 'a',
    'Article': 'article',
    'Aside': 'aside',
    'Audio': 'audio',
    'BidirectionalIsolate': 'bdi',
    'BidirectionalTextOverride': 'bdo',
    'BlockQuote': 'blockquote',
    'LineBreak': 'br',
    'Button': 'button',
    'Canvas': 'canvas',
    'TableCaption': 'caption',
    'Citation': 'cite',
    'InlineCode': 'code',
    'Data': 'data',
    'DataList': 'datalist',
    'Definition': 'dfn',
    'DeletedText': 'del',
    'DescriptionDetails': 'dd',
    'DescriptionList': 'dl',
    'DescriptionTerm': 'dt',
    'Details': 'details',
    'Dialog': 'dialog',
    'Division': 'div',
    'EmbedExternal': 'embed',
    'EmbedTextTrack': 'track',
    'Emphasis': 'em',
    'FieldSet': 'fieldset',
    'Figure': 'figure',
    'FigureCaption': 'figcaption',
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
    'ImageMap': 'map',
    'ImageMapArea': 'area',
    'InlineQuotation': 'q',
    'Input': 'input',
    'InsertedText': 'ins',
    'KeyboardInput': 'kbd',
    'Label': 'label',
    'Legend': 'legend',
    'LineBreakOpportunity': 'wbr',
    'ListItem': 'li',
    'MarkText': 'mark',
    'MediaSource': 'source',
    'Menu': 'menu',
    'Meter': 'meter',
    'Navigation': 'nav',
    'OrderedList': 'ol',
    'Option': 'option',
    'OptionGroup': 'optgroup',
    'Output': 'output',
    'Paragraph': 'p',
    'Picture': 'picture',
    'Portal': 'portal',
    'PreformattedText': 'pre',
    'Progress': 'progress',
    'RubyAnnotation': 'ruby',
    'RubyFallbackParenthesis': 'rp',
    'RubyText': 'rt',
    'SampleOutput': 'samp',
    'Select': 'select',
    'Small': 'small',
    'Span': 'span',
    'StrikeThrough': 's',
    'Strong': 'strong',
    'SubScript': 'sub',
    'Summary': 'summary',
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
    'Time': 'time',
    'UnOrderedList': 'ul',
    'Variable': 'var',
    'Video': 'video',

    # additionals,

    'InputButton': 'input',
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
            // Copyright (c) 2022, Rad developers. All rights reserved.
            // Use of this source code is governed by a BSD-style license that can be 
            // found in the LICENSE file.

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
                templates_folder, test + '.dart'))

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

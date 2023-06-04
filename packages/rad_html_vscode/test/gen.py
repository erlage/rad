# Copyright (c) 2022-2023 H. Singh <hamsbrar@gmail.com>. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

#!/usr/bin/env python3

import os
import shutil

scripts_dir = os.path.abspath(os.path.dirname(__file__))

src_dir = os.path.abspath(os.path.join(scripts_dir, os.path.pardir, os.path.pardir, 'rad', 'test'))
out_dir = os.path.abspath(os.path.join(scripts_dir, 'out'))

skipped_tests = {
    'html_internal_markup': {
        'var':      ['chrome'], # reserved word 
    }
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
        'html_attr_disabled',
        'html_attr_form',
        'html_attr_input_mode',
        'html_attr_tabindex',
        'html_attr_value',
        
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
        'html_attr_auto_complete',
        'html_attr_name',
        'html_attr_form',
        'html_attr_size',
        'html_attr_required',
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
        'html_attr_abbr',
        'html_attr_rowspan',
        'html_attr_colspan',
        'html_attr_scope',
        'html_attr_headers',
    ],
    'TextArea': [
        'html_attr_auto_complete',
        'html_attr_form',
        'html_attr_spell_check',
        'html_attr_wrap',

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
        'html_prop_value_widget_class',
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
}

global_tests = [
    'html_attr_id',
    'html_attr_children_positional',
    'html_attr_class_name',
    'html_attr_hidden',
    'html_attr_on_click',
    'html_attr_style',
    'html_attr_title',
    'html_ref_callback',
    'html_internal_markup',
    'html_attr_additional_attributes',
    'html_short_tag',
    'widget_key',
]

widgets_map = {
    'abbr': 'Abbreviation',
    'address': 'Address',
    'a': 'Anchor',
    'article': 'Article',
    'aside': 'Aside',
    'audio': 'Audio',
    'bdi': 'BidirectionalIsolate',
    'bdo': 'BidirectionalTextOverride',
    'blockquote': 'BlockQuote',
    'br': 'LineBreak',
    'button': 'Button',
    'canvas': 'Canvas',
    'caption': 'TableCaption',
    'cite': 'Citation',
    'code': 'InlineCode',
    'data': 'Data',
    'datalist': 'DataList',
    'dfn': 'Definition',
    'del': 'DeletedText',
    'dd': 'DescriptionDetails',
    'dl': 'DescriptionList',
    'dt': 'DescriptionTerm',
    'details': 'Details',
    'dialog': 'Dialog',
    'div': 'Division',
    'embed': 'EmbedExternal',
    'track': 'EmbedTextTrack',
    'em': 'Emphasis',
    'fieldset': 'FieldSet',
    'figure': 'Figure',
    'figcaption': 'FigureCaption',
    'footer': 'Footer',
    'form': 'Form',
    'h1': 'Heading1',
    'h2': 'Heading2',
    'h3': 'Heading3',
    'h4': 'Heading4',
    'h5': 'Heading5',
    'h6': 'Heading6',
    'header': 'Header',
    'hr': 'HorizontalRule',
    'iframe': 'IFrame',
    'i': 'Idiomatic',
    'img': 'Image',
    'map': 'ImageMap',
    'area': 'ImageMapArea',
    'q': 'InlineQuotation',
    'input': 'Input',
    'ins': 'InsertedText',
    'kbd': 'KeyboardInput',
    'label': 'Label',
    'legend': 'Legend',
    'wbr': 'LineBreakOpportunity',
    'li': 'ListItem',
    'mark': 'MarkText',
    'source': 'MediaSource',
    'menu': 'Menu',
    'meter': 'Meter',
    'nav': 'Navigation',
    'ol': 'OrderedList',
    'option': 'Option',
    'optgroup': 'OptionGroup',
    'output': 'Output',
    'p': 'Paragraph',
    'picture': 'Picture',
    'portal': 'Portal',
    'pre': 'PreformattedText',
    'progress': 'Progress',
    'ruby': 'RubyAnnotation',
    'rp': 'RubyFallbackParenthesis',
    'rt': 'RubyText',
    'samp': 'SampleOutput',
    'select': 'Select',
    'small': 'Small',
    'span': 'Span',
    's': 'StrikeThrough',
    'strong': 'Strong',
    'sub': 'SubScript',
    'summary': 'Summary',
    'sup': 'SuperScript',
    'table': 'Table',
    'tbody': 'TableBody',
    'col': 'TableColumn',
    'colgroup': 'TableColumnGroup',
    'td': 'TableDataCell',
    'tfoot': 'TableFoot',
    'thead': 'TableHead',
    'th': 'TableHeaderCell',
    'tr': 'TableRow',
    'textarea': 'TextArea',
    'time': 'Time',
    'ul': 'UnOrderedList',
    'var': 'Variable',
    'video': 'Video',
}

reserved_name_map = {
    'var': 'vartag',
}

def parse_test_from_template(template, replacements):
    default_replacements = [
        ('__Skip__', ''),
    ]

    with open(template, 'r') as file:
        contents = file.read()

        for key, value in replacements:
            contents = contents.replace(key, value)

        for key, value in default_replacements:
            contents = contents.replace(key, value)

        return contents

def copy_dir(src_dir, dst_dir):
    if os.path.exists(dst_dir):
        shutil.rmtree(dst_dir)

    if not os.path.exists(dst_dir):
        os.makedirs(dst_dir) 

    for filename in os.listdir(src_dir):
        src_file = os.path.join(src_dir, filename)
        dst_file = os.path.join(dst_dir, filename)
        if os.path.isfile(src_file):
            shutil.copy2(src_file, dst_file)

def copy_file(src_file, dst_file):
    if os.path.exists(dst_file):
        os.unlink(dst_file)

    shutil.copy2(src_file, dst_file)

def generate():
    if os.path.exists(out_dir):
        shutil.rmtree(out_dir)
    
    src_templates_dir = os.path.abspath(os.path.join(src_dir, 'templates', 'html'))
    dst_templates_dir = os.path.abspath(os.path.join(out_dir, 'templates'))
    copy_dir(src_templates_dir, dst_templates_dir);
    for filename in os.listdir(dst_templates_dir):
        template_file = os.path.join(dst_templates_dir, filename)
        if os.path.isfile(template_file):
            with open(template_file, 'r') as file:
                contents = file.read()

            contents = contents.replace("__WidgetTag__", "__WidgetClass__")
            contents = contents.replace("__WidgetClass__(", "__WidgetClass__([], ")
            contents = contents.replace("export 'package:rad/widgets_html.dart';", "")
            contents = contents.replace("export 'package:rad/widgets_short_html.dart';", "export 'package:rad/rad_html_vscode.dart';")

            with open(template_file, 'w') as file:
                file.write(contents)

    copy_file(os.path.abspath(os.path.join(src_dir, 'test_imports.dart')), os.path.abspath(os.path.join(out_dir, 'test_imports.dart')));
    imports_file = os.path.abspath(os.path.join(out_dir, 'test_imports.dart'))
    if os.path.isfile(imports_file):
        with open(imports_file, 'r') as file:
            contents = file.read()
        
        contents = contents.replace("export 'package:rad/widgets_html.dart';", "")
        contents = contents.replace("export 'package:rad/widgets_short_html.dart';", "export 'package:rad_html_vscode/rad_html_vscode.dart';")
        contents = contents.replace("export 'fixtures/test_hook.dart';", "")
        contents = contents.replace("export 'fixtures/test_widget_eventful.dart';", "")
        
        with open(imports_file, 'w') as file:
            file.write(contents)

    copy_dir(os.path.abspath(os.path.join(src_dir, 'constants')), os.path.abspath(os.path.join(out_dir, 'constants')));
    copy_dir(os.path.abspath(os.path.join(src_dir, 'fixtures')), os.path.abspath(os.path.join(out_dir, 'fixtures')));
    copy_dir(os.path.abspath(os.path.join(src_dir, 'matchers')), os.path.abspath(os.path.join(out_dir, 'matchers')));
    copy_dir(os.path.abspath(os.path.join(src_dir, 'mocks')), os.path.abspath(os.path.join(out_dir, 'mocks')));

    copy_file(os.path.abspath(os.path.join(src_dir, 'utils.dart')), os.path.abspath(os.path.join(out_dir, 'utils.dart')));

    if os.path.exists(os.path.abspath(os.path.join(out_dir, 'mocks/test_framework.dart'))):
        os.unlink(os.path.abspath(os.path.join(out_dir, 'mocks/test_framework.dart')))
    if os.path.exists(os.path.abspath(os.path.join(out_dir, 'fixtures/test_hook.dart'))):
        os.unlink(os.path.abspath(os.path.join(out_dir, 'fixtures/test_hook.dart')))
    if os.path.exists(os.path.abspath(os.path.join(out_dir, 'fixtures/test_widget_eventful.dart'))):
        os.unlink(os.path.abspath(os.path.join(out_dir, 'fixtures/test_widget_eventful.dart')))

    fixtures_file = os.path.abspath(os.path.join(out_dir, 'fixtures/test_app.dart'))
    if os.path.isfile(fixtures_file):
        with open(fixtures_file, 'r') as file:
            contents = file.read()
        new_line = "// ignore_for_file: invalid_use_of_internal_member\n\n"
        contents = new_line + contents
        with open(fixtures_file, 'w') as file:
            file.write(contents)

    invocations = ''
    part_of_directives = ''
    runner_file = os.path.abspath(os.path.join(out_dir, 'tests', 'generated', '_index_html_test.dart'))
    if os.path.exists(runner_file) and os.path.isfile(runner_file):
        os.unlink(runner_file)

    for index, widget_tag_name in enumerate(widgets_map):
        widget_class_name = widgets_map[widget_tag_name]

        out_file = os.path.abspath(os.path.join(out_dir, 'tests', 'generated', 'html', 'html_' + widget_tag_name + '_tests.generated.dart'))
        if os.path.exists(out_file) and os.path.isfile(out_file):
            os.unlink(out_file)

        invocations += 'html_' + widget_tag_name + '_test();'

        part_of_directives += "part 'html/html_" + \
            widget_tag_name + "_tests.generated.dart';"

        generated = ''' 
            // Copyright (c) 2022-2023 H. Singh <hamsbrar@gmail.com>. All rights reserved.
            // Use of this source code is governed by a BSD-style license that can be 
            // found in the LICENSE file.

            // Auto-generated file
            //
            // Sources of these tests can be found in /test/templates folder

            // ignore_for_file: non_constant_identifier_names, invalid_use_of_internal_member

            part of '../_index_html_test.dart';

            void html_''' + widget_tag_name + '''_test() {

                group('HTML ''' + widget_tag_name + ''' tests:', () {
            
                    RT_AppRunner? app;

                    setUp(() {
                        app = createTestApp()..start();
                    });

                    tearDown(() => app!.stop());
            '''

        for test in global_tests:
            generated += '\n\n'

            widget_class_name_replacement = widget_tag_name;
            if widget_tag_name in reserved_name_map:
                widget_class_name_replacement = reserved_name_map[widget_tag_name]

            replacements = [
                ('__WidgetClass__Element', widget_class_name + 'Element'),
                ('__WidgetClass__', widget_class_name_replacement), # since there are only short tags
            ]

            test_tpl = os.path.abspath(os.path.join(dst_templates_dir, test + '.dart'))

            skip_context = ''
            if test in skipped_tests and widget_tag_name in skipped_tests[test]:
                skip_context = ', onPlatform: {'

                for platform in skipped_tests[test][widget_tag_name]:
                    skip_context += "'" + platform + \
                        "': Skip('Failing for " + widget_tag_name + \
                        " on " + platform + "'),"

                skip_context += '}'
                replacements.append(('__Skip__', skip_context))

            generated += parse_test_from_template(test_tpl, replacements)

        # generate widget specific tests

        if widget_class_name in widget_specific_tests:
            for test in widget_specific_tests[widget_class_name]:
                generated += '\n\n'

                test_tpl = os.path.abspath(os.path.join(dst_templates_dir, test + '.dart'))

                generated += parse_test_from_template(test_tpl, replacements)

        generated += '}); \n\n }'

        os.makedirs(os.path.dirname(out_file), exist_ok=True)

        fh = open(out_file, 'w+')
        fh.write(generated)
        fh.close()

    runner_code = ''' 
        // Copyright (c) 2022-2023 H. Singh <hamsbrar@gmail.com>. All rights reserved.
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

    os.system('dart format ' + os.path.abspath(os.path.join(out_dir, 'generated')))

generate();
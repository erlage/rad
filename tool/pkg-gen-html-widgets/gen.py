# Copyright (c) 2022, Rad developers. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

#!/usr/bin/env python3

from fileinput import filename
import os
import re
import shutil
import argparse

__package_repo__ = 'https://github.com/erlage/rad'
__package_version__ = '0.1.0'

__package_name__ = 'rad_custom_html_widgets'
__package_description__ = 'Custom HTML widgets for using with Rad'

# This file is kept in sync with main repo so it may not be compaitable with
# published version of rad.
#
# For generating HTML widgets compaitable with Rad v.0.10.0
# 
# - git checkout 35958c12f1abac32f299df85f1294d61abdd553e
# 

generator_dir = os.path.abspath(os.path.dirname(__file__))
tool_dir = os.path.abspath(os.path.join(generator_dir, os.path.pardir))
root_dir = os.path.abspath(os.path.join(tool_dir, os.path.pardir))

rad_pkg_dir = os.path.abspath(os.path.join(root_dir, 'packages', 'rad'))
rad_pkg_widgets_dir = os.path.abspath(os.path.join(rad_pkg_dir, 'lib', 'src', 'widgets'))
rad_pkg_html_widgets_dir = os.path.abspath(os.path.join(rad_pkg_widgets_dir, 'html'))

abstract_files = [
    'html_widget_base.dart',
    'html_altered_text_base.dart',
    'html_bidirectional_base.dart',
    'html_table_cell_base.dart',
    'html_table_column_base.dart',
]

rexp_core_import = re.compile("(import 'package:rad\/src\/)([^;]*);")

__parsed_args__ = {}

cmd_class_name_change_name = 'className:rename'
cmd_class_name_change_type = 'className:retype'

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

def clear_folder(dir):
    if os.path.exists(dir):
        for the_file in os.listdir(dir):
            file_path = os.path.join(dir, the_file)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
                else:
                    clear_folder(file_path)
                    os.rmdir(file_path)
            except Exception as e:
                print(e)


def clean_file(file):
    if os.path.exists(file) and os.path.isfile(file):
        os.unlink(file)


def setup_dir(out_dir):
    clear_folder(out_dir)
    os.makedirs(out_dir, exist_ok=True)

# =======================================================================
#  process
# =======================================================================

def copy_html_widgets(out_dir):

    # copy HTML widgets

    for base_file_name in os.listdir(rad_pkg_html_widgets_dir):
        src = os.path.join(rad_pkg_html_widgets_dir, base_file_name)
        dst = os.path.join(out_dir, base_file_name)
        shutil.copyfile(src, dst)

    # copy base classes

    base_file_src_path = os.path.join(rad_pkg_html_widgets_dir, os.path.pardir, 'abstract')
    base_file_dst_path = os.path.join(out_dir, 'abstract')
    os.makedirs(base_file_dst_path, exist_ok=True)

    for base_file_name in abstract_files:
        base_file_src = os.path.join(base_file_src_path, base_file_name)
        base_file_dst = os.path.join(base_file_dst_path, base_file_name)
        shutil.copyfile(base_file_src, base_file_dst)


def process_html_widgets(out_dir):
    # operate on widget files

    widget_files = os.listdir(out_dir)

    for file_name in widget_files:
        file_path = os.path.join(out_dir, file_name)
        if os.path.isfile(file_path):
            with open(file_path, 'r') as file:
                contents = file.read()

                contents = apply_commons_widget_file(file_name, contents)
                contents = apply_property_changes_on_widget_file(file_name, contents)

                fh = open(file_path, 'w+')
                fh.write(contents)
                fh.close()

    # operate on base files

    for file_name in abstract_files:
        file_path = os.path.join(out_dir, 'abstract', file_name)
        with open(file_path, 'r') as file:
            contents = file.read()

            contents = apply_commons_base_file(file_name, contents)
            contents = apply_property_changes_on_base_file(file_name, contents)

            fh = open(file_path, 'w+')
            fh.write(contents)
            fh.close()




# =======================================================================
#  package finalizer
# =======================================================================

def finalize_package(out_dir):
    new_dir_for_widgets = os.path.join(out_dir, 'lib', 'src', 'widgets')
    new_dir_for_html_widgets = os.path.join(out_dir, 'lib', 'src', 'widgets', 'html')
    setup_dir(new_dir_for_widgets)
    setup_dir(new_dir_for_html_widgets)

    # add html widgets

    html_widget_files = os.listdir(out_dir)
    for file in html_widget_files:
        file_path = os.path.join(out_dir, file)
        if os.path.isfile(file_path):
            src = os.path.join(out_dir, file)
            dst = os.path.join(new_dir_for_html_widgets, file)
            shutil.move(src, dst)

    # add base classes
    
    base_html_widget_src_path = os.path.join(out_dir, 'abstract')
    base_html_widget_dst_path = os.path.join(new_dir_for_widgets)
    shutil.move(base_html_widget_src_path, base_html_widget_dst_path)

    # add pubspec

    pubspec_file_src_path = os.path.join(generator_dir, 'assets', 'pubspec.yaml')
    pubspec_file_dst_path = os.path.join(out_dir, 'pubspec.yaml')
    with open(pubspec_file_src_path, 'r') as file:
        contents = file.read()
        contents = apply_package_properties(contents)
        fh = open(pubspec_file_dst_path, 'w+')
        fh.write(contents)
        fh.close()

    # add readme

    readme_file_src_path = os.path.join(generator_dir, 'assets', 'README.md')
    readme_file_dst_path = os.path.join(out_dir, 'README.md')
    with open(readme_file_src_path, 'r') as file:
        contents = file.read()
        contents = apply_package_properties(contents)
        fh = open(readme_file_dst_path, 'w+')
        fh.write(contents)
        fh.close()

    # add library file

    html_widgets_lib_file = os.path.join(rad_pkg_dir, 'lib', 'widgets_html.dart')
    new_lib_file_path = os.path.join(out_dir, 'lib', __package_name__ + '.dart')
    
    with open(html_widgets_lib_file, 'r') as file:
        contents = file.read()

        contents = contents.replace('library widgets_html', 'library ' + __package_name__)
        rexp_remove_additional_exports = re.compile("(export 'src\/widgets\/additional)([^;]*);")
        contents = rexp_remove_additional_exports.sub('', contents)

        fh = open(new_lib_file_path, 'w+')
        fh.write(contents)
        fh.close()

    # add license

    src = os.path.join(root_dir, 'LICENSE')
    dst = os.path.join(out_dir, 'LICENSE')
    shutil.copyfile(src, dst)

# =======================================================================
#  package properties
# =======================================================================

def apply_package_properties(contents):
    contents = contents.replace('__package_repo__', __package_repo__)
    contents = contents.replace('__package_version__', __package_version__)
    contents = contents.replace('__package_name__', __package_name__)
    contents = contents.replace('__package_description__', __package_description__)

    return contents

# =======================================================================
#  commons
# =======================================================================

def apply_commons_widget_file(file_name, contents):
    return apply_commons(file_name, contents)
def apply_commons_base_file(file_name, contents):
    return apply_commons(file_name, contents)

def apply_commons(file_name, contents):
    contents = contents.replace('ccImmutableEmptyListOfWidgets', "const []")
    contents = contents.replace('ccImmutableEmptyMapOfEventListeners', "const {}")

    contents = contents.replace('Attributes.id', "'id'")
    contents = contents.replace('Attributes.title', "'title'")
    contents = contents.replace('Attributes.style', "'style'")
    contents = contents.replace('Attributes.className', "'class'")
    contents = contents.replace('Attributes.dir', "'dir'")
    contents = contents.replace('Attributes.hidden', "'hidden'")
    contents = contents.replace('Attributes.tabIndex', "'tabindex'")
    contents = contents.replace('Attributes.draggable', "'draggable'")
    contents = contents.replace('Attributes.contentEditable', "'contentEditable'")
    contents = contents.replace('Attributes.type', "'type'")
    contents = contents.replace('Attributes.name', "'name'")
    contents = contents.replace('Attributes.value', "'value'")
    contents = contents.replace('Attributes.accept', "'accept'")
    contents = contents.replace('Attributes.multiple', "'multiple'")
    contents = contents.replace('Attributes.disabled', "'disabled'")
    contents = contents.replace('Attributes.required', "'required'")
    contents = contents.replace('Attributes.checked', "'checked'")
    contents = contents.replace('Attributes.placeholder', "'placeholder'")
    contents = contents.replace('Attributes.readOnly', "'readonly'")
    contents = contents.replace('Attributes.rowSpan', "'rowspan'")
    contents = contents.replace('Attributes.colSpan', "'colspan'")
    contents = contents.replace('Attributes.headers', "'headers'")
    contents = contents.replace('Attributes.span', "'span'")
    contents = contents.replace('Attributes.rel', "'rel'")
    contents = contents.replace('Attributes.target', "'target'")
    contents = contents.replace('Attributes.href', "'href'")
    contents = contents.replace('Attributes.download', "'download'")
    contents = contents.replace('Attributes.cite', "'cite'")
    contents = contents.replace('Attributes.action', "'action'")
    contents = contents.replace('Attributes.method', "'method'")
    contents = contents.replace('Attributes.enctype', "'enctype'")
    contents = contents.replace('Attributes.rows', "'rows'")
    contents = contents.replace('Attributes.cols', "'cols'")
    contents = contents.replace('Attributes.minLength', "'minlength'")
    contents = contents.replace('Attributes.maxLength', "'maxlength'")
    contents = contents.replace('Attributes.allowFullscreen', "'allowfullscreen'")
    contents = contents.replace('Attributes.allowPaymentRequest', "'allowpaymentrequest'")
    contents = contents.replace('Attributes.allow', "'allow'")
    contents = contents.replace('Attributes.max', "'max'")
    contents = contents.replace('Attributes.label', "'label'")
    contents = contents.replace('Attributes.selected', "'selected'")
    contents = contents.replace('Attributes.forAttribute', "'for'")
    contents = contents.replace('Attributes.pattern', "'pattern'")
    contents = contents.replace('Attributes.src', "'src'")
    contents = contents.replace('Attributes.alt', "'alt'")
    contents = contents.replace('Attributes.height', "'height'")
    contents = contents.replace('Attributes.width', "'width'")
    contents = contents.replace('Attributes.content', "'content'")
    contents = contents.replace('Attributes.charset', "'charset'")
    contents = contents.replace('Attributes.httpEquiv', "'http-equiv'")
    contents = contents.replace('Attributes.start', "'start'")
    contents = contents.replace('Attributes.reversed', "'reversed'")
    contents = contents.replace('Attributes.dateTime', "'datetime'")
    contents = contents.replace('Attributes.coords', "'coords'")
    contents = contents.replace('Attributes.hrefLang', "'hreflang'")
    contents = contents.replace('Attributes.ping', "'ping'")
    contents = contents.replace('Attributes.referrerPolicy', "'referrerpolicy'")
    contents = contents.replace('Attributes.shape', "'shape'")
    contents = contents.replace('Attributes.autoPlay', "'autoplay'")
    contents = contents.replace('Attributes.controls', "'controls'")
    contents = contents.replace('Attributes.crossOrigin', "'crossorigin'")
    contents = contents.replace('Attributes.loop', "'loop'")
    contents = contents.replace('Attributes.muted', "'muted'")
    contents = contents.replace('Attributes.preload', "'preload'")
    contents = contents.replace('Attributes.defaultAttribute', "'default'")
    contents = contents.replace('Attributes.kind', "'kind'")
    contents = contents.replace('Attributes.srcLang', "'srclang'")
    contents = contents.replace('Attributes.playsInline', "'playsinline'")
    contents = contents.replace('Attributes.poster', "'poster'")
    contents = contents.replace('Attributes.srcSet', "'srcset'")
    contents = contents.replace('Attributes.open', "'open'")
    contents = contents.replace('Attributes.form', "'form'")
    contents = contents.replace('Attributes.min', "'min'")
    contents = contents.replace('Attributes.low', "'low'")
    contents = contents.replace('Attributes.high', "'high'")
    contents = contents.replace('Attributes.optimum', "'optimum'")

    contents = contents.replace('Properties.value', "'value'")
    contents = contents.replace('Properties.innerHtml', "'innerHtml'")
    contents = contents.replace('Properties.innerText', "'innerText'")

    for base_file_name in abstract_files:
        contents = contents.replace("import 'package:rad/src/widgets/abstract/"+base_file_name+"';", "import 'package:"+__package_name__+"/src/widgets/abstract/"+base_file_name+"';")
     
    # fix imports

    core_import_count = len(rexp_core_import.findall(contents))
    if core_import_count > 0:
        contents = rexp_core_import.sub('', contents, core_import_count - 1)
        contents = rexp_core_import.sub("import 'package:rad/rad.dart';", contents)

    if file_name == 'html_widget_base.dart' :
        contents += '''

            bool fnIsKeyValueMapEqual(
                    Map<String, String>? mapOne,
                    Map<String, String>? mapTwo,
            ) {
                // 1. if same instance(or both are null)
                if (mapOne == mapTwo) return true;

                // 2. if one of them is null, this mean other is not
                if (null == mapOne || null == mapTwo) return false;

                // 3. if lengths are different
                if (mapOne.length != mapTwo.length) return false;

                // 4. walk
                for (final key in mapOne.keys) {
                    if (mapOne[key] != mapTwo[key]) return false;
                }

                return true;
            }
            
        '''

    return contents

# =======================================================================
#  properties
# =======================================================================

def apply_property_changes_on_widget_file(file_name, contents):
    contents = apply_class_name_property_change_on_widget_file(file_name, contents)
    return contents;

def apply_property_changes_on_base_file(file_name, contents):
    contents = apply_class_name_property_change_on_base_file(file_name, contents)
    return contents;

def apply_class_name_property_change_on_widget_file(file_name, contents):
    className_name = __parsed_args__[cmd_class_name_change_name]
    className_type = __parsed_args__[cmd_class_name_change_type]

    cur_name_signature = 'className'
    cur_type_signature = 'String?'

    if className_name != 'className':
        new_name_signature = className_name
        contents = contents.replace(cur_name_signature, new_name_signature)
        cur_name_signature = className_name

    if className_type != 'string':
        if className_type == 'set':
            new_type_signature = 'Set<String>?'
        else:
            new_type_signature = 'List<String>?'

        contents = contents.replace(f'{cur_type_signature} {cur_name_signature}', f'{new_type_signature} {cur_name_signature}')
        cur_type_signature = new_type_signature

    return contents

def apply_class_name_property_change_on_base_file(file_name, contents):
    className_name = __parsed_args__[cmd_class_name_change_name]
    className_type = __parsed_args__[cmd_class_name_change_type]

    cur_name_signature = 'className'
    cur_type_signature = 'String?'

    if className_name != cur_name_signature:
        new_name_signature = className_name
        contents = contents.replace(cur_name_signature, new_name_signature)
        cur_name_signature = className_name

    if className_type != 'string':
        if className_type == 'set':
            new_type_signature = 'Set<String>?'
        else:
            new_type_signature = 'List<String>?'

        contents = contents.replace(f'{cur_type_signature} {cur_name_signature}', f'{new_type_signature} {cur_name_signature}')
        contents = contents.replace(f'{cur_name_signature} != oldWidget.{cur_name_signature}', f'_c({cur_name_signature}) != _c(oldWidget.{cur_name_signature})')
        contents = contents.replace(f'] = widget.{cur_name_signature};', f'] = _c(widget.{cur_name_signature});')
        
        if(file_name == 'html_widget_base.dart'):
            contents += f"{cur_type_signature} _c({new_type_signature} classes) => classes?.join(' ');"

        cur_type_signature = new_type_signature

    return contents


# =======================================================================
#  main
# =======================================================================

def validate():
    passed = True

    package_name_check = re.compile('[^a-zA-Z_]+')
    if package_name_check.search(__package_name__):
        passed = False
        print(bcolors.FAIL + f"Warning: Package cannot contain any special character." + bcolors.ENDC)

    package_version_check = re.compile('[^0-9.]+')
    if package_version_check.search(__package_version__):
        passed = False
        print(bcolors.FAIL + f"Warning: Package version specified is invalid." + bcolors.ENDC)

    class_name_check = re.compile('[^a-zA-Z]+')
    if class_name_check.search(__parsed_args__[cmd_class_name_change_name]):
        passed = False
        print(bcolors.FAIL + f"Warning: Name specified for property className is not valid" + bcolors.ENDC)

    if not passed:
        raise 'Something went wrong while generating package'

if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    parser.add_argument('--name', default=__package_name__, help='Package name to set', type=str)
    parser.add_argument('--description', default=__package_description__, help='Package description to set', type=str)
    parser.add_argument('--repo', default=__package_repo__, help='Package repository to set', type=str)
    parser.add_argument('--version', default=__package_version__, help='Package version to set', type=str)
    
    parser.add_argument('--' + cmd_class_name_change_name, default='className', help='Change className to something else', type=str)
    parser.add_argument('--' + cmd_class_name_change_type, choices=['string', 'set', 'list'], default='string', help='Change type of className', type=str)
    parser.add_argument('--out', default='out', help='Output directory for generated package', type=str)

    __parsed_args__ = vars(parser.parse_args())

    __package_name__ = __parsed_args__['name']
    __package_description__ = __parsed_args__['description']
    __package_repo__ = __parsed_args__['repo']
    __package_version__ = __parsed_args__['version']
    out_dir = os.path.abspath(os.path.join(generator_dir, __parsed_args__['out']))

    validate()

    setup_dir(out_dir)

    copy_html_widgets(out_dir)
    process_html_widgets(out_dir)

    finalize_package(out_dir)

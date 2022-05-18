// ignore_for_file: non_constant_identifier_names

// auto-generated. please don't edit this file

import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/list_view.dart';
import 'package:rad/src/widgets/navigator.dart';
import 'package:rad/src/widgets/rad_app.dart';
import 'package:rad/src/widgets/route.dart';
import 'package:rad/src/widgets/stateful_widget.dart';
import 'package:rad/src/widgets/stateless_widget.dart';

final GEN_STYLES_MAIN_CSS = ''
    ' /** '
    '    * RadApp widget '
    '    */ '
    '  '
    ' [data-rad-wtype="$RadApp"] { '
    '     width: 100%; '
    '     height: 100%; '
    ' } '
    '  '
    '  '
    ' /** '
    '    * widgets without any styles/display '
    '    */ '
    '  '
    ' [data-rad-wtype="$Route"], '
    ' [data-rad-wtype="$Navigator"], '
    ' [data-rad-wtype="$InheritedWidget"], '
    ' [data-rad-wtype="$StatefulWidget"], '
    ' [data-rad-wtype="$StatelessWidget"] { '
    '     display: contents; '
    ' } '
    '  '
    '  '
    ' /** '
    '    * ListView widget '
    '    */ '
    '  '
    ' [data-rad-wtype="$ListView"] { '
    '     width: 100%; '
    '     height: 100%; '
    ' } '
    '  '
    ' .rad-list-view-layout-contain { '
    '     max-width: 100vw; '
    '     max-height: 100vh; '
    '     overflow: auto; '
    ' } '
    '  '
    ' .rad-list-view-layout-expand { '
    '     overflow: auto; '
    ' } '
    '  '
    ' .rad-list-view-vertical { '
    '     overflow-x: hidden; '
    '     overflow-y: auto; '
    '     flex-direction: column; '
    ' } '
    '  '
    ' .rad-list-view-horizontal { '
    '     overflow-x: auto; '
    '     overflow-y: hidden; '
    '     flex-direction: row; '
    ' } '
    '  '
    '  '
    ' /** '
    "    * Make sure flex do not shrink/grow for ListView's childs "
    '    */ '
    '  '
    ' [data-rad-wtype="$ListView"]>*, '
    ' .rad-list-view-item-container>* { '
    '     flex-grow: 0; '
    '     flex-shrink: 0; '
    '     display: flex; '
    ' } '
    '  '
    '  '
    ' /** '
    '    * System classes '
    '    */ '
    '  '
    ' .rad-hidden { '
    '     display: none !important; '
    '     visibility: hidden !important; '
    ' } ';

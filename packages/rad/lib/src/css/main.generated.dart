// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: directives_ordering
// ignore_for_file: prefer_single_quotes
// ignore_for_file: constant_identifier_names
// ignore_for_file: avoid_escaping_inner_quotes

// auto-generated. please don't edit this file

const GEN_STYLES_MAIN_CSS = ""
    " /** "
    "    * RadApp widget "
    "    */ "
    "  "
    " .rad-app { "
    "     width: 100%; "
    "     height: 100%; "
    " } "
    "  "
    "  "
    " /** "
    "    * widgets that has corresponding node in dom  "
    "    * but we want to limit their impact/disrupt in layout/markup "
    "    */ "
    "  "
    " .rad-route, "
    " .rad-router-element, "
    " .rad-gesture-detector { "
    "     display: contents; "
    " } "
    "  "
    "  "
    " /** "
    "    * ListView widget "
    "    */ "
    "  "
    " .rad-list-view { "
    "     width: 100%; "
    "     height: 100%; "
    " } "
    "  "
    " .rad-list-view-layout-contain { "
    "     max-width: 100vw; "
    "     max-height: 100vh; "
    "     overflow: auto; "
    " } "
    "  "
    " .rad-list-view-layout-expand { "
    "     overflow: auto; "
    " } "
    "  "
    " .rad-list-view-vertical { "
    "     overflow-x: hidden; "
    "     overflow-y: auto; "
    "     flex-direction: column; "
    " } "
    "  "
    " .rad-list-view-horizontal { "
    "     overflow-x: auto; "
    "     overflow-y: hidden; "
    "     flex-direction: row; "
    " } "
    "  "
    "  "
    " /** "
    "    * Make sure flex do not shrink/grow for ListView's child widgets "
    "    */ "
    "  "
    " .rad-list-view>*, "
    " .rad-list-view-item-container>* { "
    "     flex-grow: 0; "
    "     flex-shrink: 0; "
    "     display: flex; "
    " } "
    "  "
    "  "
    " /** "
    "    * System classes "
    "    */ "
    "  "
    " .rad-hidden { "
    "     display: none !important; "
    "     visibility: hidden !important; "
    " } ";

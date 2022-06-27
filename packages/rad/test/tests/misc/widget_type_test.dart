// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | these tests are to ensure that widgetType overrides are correct
  |
  | following widgets neet not to be tested because they are built on top of 
  | other widgets
  |
  | - AsyncRoute
  | - FutureBuilder
  | - StreamBuilder
  | - GestureDetector
  | - ValueListenableBuilder
  |
  | --- from additionals
  |
  | - Text
  | - InputText
  | - InputFile
  | - InputRadio
  | - InputSubmit
  | - InputCheckBox
  |
  |--------------------------------------------------------------------------
  */

  group('widgetType override tests, abstract widgets:', () {
    test('Inherited widget', () {
      var widget = RT_InheritedWidget(child: Text('hw'));

      expect(widget.widgetType, '$InheritedWidget');
    });

    test('Stateful widget', () {
      var widget = RT_StatefulTestWidget();

      expect(widget.widgetType, '$StatefulWidget');
    });

    test('Stateless widget', () {
      var widget = RT_StatelessWidget();

      expect(widget.widgetType, '$StatelessWidget');
    });
  });

  group('widgetType override tests, main widgets:', () {
    test('Navigator widget', () {
      var widget = Navigator(routes: []);

      expect(widget.widgetType, '$Navigator');
    });

    test('Route widget', () {
      var widget = Route(
        name: '',
        page: Text('hw'),
      );

      expect(widget.widgetType, '$Route');
    });

    test('RadApp widget', () {
      var widget = RadApp(child: Text(''));
      expect(widget.widgetType, '$RadApp');
    });

    test('RawMarkUp widget', () {
      var widget = RawMarkUp('');
      expect(widget.widgetType, '$RawMarkUp');
    });

    test('ListView widget', () {
      var widget = ListView(children: []);
      expect(widget.widgetType, '$ListView');
    });

    test('EventDetector widget', () {
      var widget = EventDetector(child: Text('hw'));
      expect(widget.widgetType, '$EventDetector');
    });
  });

  // --------------------------------------------------------------------------
  // HTML widgets
  // --------------------------------------------------------------------------

  group('widgetType override tests, html widgets:', () {
    test('Abbreviation widget', () {
      expect(Abbreviation().widgetType, equals('$Abbreviation'));
    });

    test('Anchor widget', () {
      expect(Anchor().widgetType, equals('$Anchor'));
    });

    test('Article widget', () {
      expect(Article().widgetType, equals('$Article'));
    });

    test('Blockquote widget', () {
      expect(BlockQuote().widgetType, equals('$BlockQuote'));
    });

    test('BreakLine widget', () {
      expect(BreakLine().widgetType, equals('$BreakLine'));
    });

    test('Button widget', () {
      expect(Button().widgetType, equals('$Button'));
    });

    test('Canvas widget', () {
      expect(Canvas().widgetType, equals('$Canvas'));
    });

    test('Caption widget', () {
      expect(Caption().widgetType, equals('$Caption'));
    });

    test('Code widget', () {
      expect(Code().widgetType, equals('$Code'));
    });

    test('Division widget', () {
      expect(Division().widgetType, equals('$Division'));
    });

    test('FieldSet widget', () {
      expect(FieldSet().widgetType, equals('$FieldSet'));
    });

    test('Footer widget', () {
      expect(Footer().widgetType, equals('$Footer'));
    });

    test('Form widget', () {
      expect(Form().widgetType, equals('$Form'));
    });

    test('Header widget', () {
      expect(Header().widgetType, equals('$Header'));
    });

    test('Heading1 widget', () {
      expect(Heading1().widgetType, equals('$Heading1'));
    });

    test('Heading2 widget', () {
      expect(Heading2().widgetType, equals('$Heading2'));
    });

    test('Heading3 widget', () {
      expect(Heading3().widgetType, equals('$Heading3'));
    });

    test('Heading4 widget', () {
      expect(Heading4().widgetType, equals('$Heading4'));
    });

    test('Heading5 widget', () {
      expect(Heading5().widgetType, equals('$Heading5'));
    });

    test('Heading6 widget', () {
      expect(Heading6().widgetType, equals('$Heading6'));
    });

    test('HorizontalRule widget', () {
      expect(HorizontalRule().widgetType, equals('$HorizontalRule'));
    });

    test('IFrame widget', () {
      expect(IFrame().widgetType, equals('$IFrame'));
    });

    test('Idiomatic widget', () {
      expect(Idiomatic().widgetType, equals('$Idiomatic'));
    });

    test('Image widget', () {
      expect(Image().widgetType, equals('$Image'));
    });

    test('Input widget', () {
      expect(Input().widgetType, equals('$Input'));
    });

    test('Label widget', () {
      expect(Label().widgetType, equals('$Label'));
    });

    test('Legend widget', () {
      expect(Legend().widgetType, equals('$Legend'));
    });

    test('ListItem widget', () {
      expect(ListItem().widgetType, equals('$ListItem'));
    });

    test('Menu widget', () {
      expect(Menu().widgetType, equals('$Menu'));
    });

    test('Navigation widget', () {
      expect(Navigation().widgetType, equals('$Navigation'));
    });

    test('Option widget', () {
      expect(Option().widgetType, equals('$Option'));
    });

    test('Paragraph widget', () {
      expect(Paragraph().widgetType, equals('$Paragraph'));
    });

    test('Progress widget', () {
      expect(Progress().widgetType, equals('$Progress'));
    });

    test('Select widget', () {
      expect(Select().widgetType, equals('$Select'));
    });

    test('Small widget', () {
      expect(Small().widgetType, equals('$Small'));
    });

    test('Span widget', () {
      expect(Span().widgetType, equals('$Span'));
    });

    test('StrikeThrough widget', () {
      expect(StrikeThrough().widgetType, equals('$StrikeThrough'));
    });

    test('Strong widget', () {
      expect(Strong().widgetType, equals('$Strong'));
    });

    test('SubScript widget', () {
      expect(SubScript().widgetType, equals('$SubScript'));
    });

    test('SuperScript widget', () {
      expect(SuperScript().widgetType, equals('$SuperScript'));
    });

    test('Table widget', () {
      expect(Table().widgetType, equals('$Table'));
    });

    test('TableColumn widget', () {
      expect(TableColumn().widgetType, equals('$TableColumn'));
    });

    test('TableColumnGroup widget', () {
      expect(TableColumnGroup().widgetType, equals('$TableColumnGroup'));
    });

    test('TableDataCell widget', () {
      expect(TableDataCell().widgetType, equals('$TableDataCell'));
    });

    test('TableFoot widget', () {
      expect(TableFoot().widgetType, equals('$TableFoot'));
    });

    test('TableHead widget', () {
      expect(TableHead().widgetType, equals('$TableHead'));
    });

    test('TableHeaderCell widget', () {
      expect(TableHeaderCell().widgetType, equals('$TableHeaderCell'));
    });

    test('TableRow widget', () {
      expect(TableRow().widgetType, equals('$TableRow'));
    });

    test('TextArea widget', () {
      expect(TextArea().widgetType, equals('$TextArea'));
    });

    test('UnOrderedList widget', () {
      expect(UnOrderedList().widgetType, equals('$UnOrderedList'));
    });
  });
}

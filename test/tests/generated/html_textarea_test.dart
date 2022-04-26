// Auto-generate file
//
// Sources of these tests can be found in /test/templates folder

import 'dart:html';

import 'package:rad/rad.dart';
import 'package:rad/widgets_html.dart';
import 'package:rad/widgets_internals.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../fixers/test_app.dart';
import '../../fixers/test_bed.dart';

void main() {
  group('HTML TextArea tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set child widget', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(
            key: GlobalKey('widget-1'),
            child: TextArea(
              key: GlobalKey('widget-2'),
            ),
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = element1.childNodes[0] as HtmlElement;

      expect(element1.id, equals('widget-1'));
      expect(element2.id, equals('widget-2'));
    });

    test('should set children widget', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('widget-1'), children: [
            TextArea(
              key: GlobalKey('widget-2'),
            ),
            TextArea(
              key: GlobalKey('widget-3'),
            ),
          ]),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = element1.childNodes[0] as HtmlElement;
      var element3 = element1.childNodes[1] as HtmlElement;

      expect(element1.id, equals('widget-1'));
      expect(element2.id, equals('widget-2'));
      expect(element3.id, equals('widget-3'));
    });

    test('should set classes', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            classAttribute: 'some class',
          ),
          TextArea(
            key: Key('widget-2'),
            classAttribute: 'some "messy" class',
          ),
          TextArea(
            key: Key('widget-3'),
            classAttribute: "some 'messy' class",
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(element1.getAttribute('class'), equals('some class'));
      expect(element2.getAttribute('class'), equals('some "messy" class'));
      expect(element3.getAttribute('class'), equals("some 'messy' class"));
    });

    test('should set contenteditable', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            contenteditable: false,
          ),
          TextArea(
            key: Key('widget-2'),
            contenteditable: true,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

      expect(element1.getAttribute('contenteditable'), equals('false'));
      expect(element2.getAttribute('contenteditable'), equals('true'));
    });

    test('should set draggable', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            draggable: false,
          ),
          TextArea(
            key: Key('widget-2'),
            draggable: true,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

      expect(element1.getAttribute('draggable'), equals('false'));
      expect(element2.getAttribute('draggable'), equals('true'));
    });

    test('should set hidden', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            hidden: false,
          ),
          TextArea(
            key: Key('widget-2'),
            hidden: true,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

      expect(element1.hidden, equals(false));
      expect(element2.hidden, equals(true));
    });

    test('should set inner text', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(
            key: GlobalKey('widget-1'),
            innerText: 'hello world',
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;

      expect(element1.innerText, equals('hello world'));
    });

    test('should set onClick', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            onClick: 'some onClick',
          ),
          TextArea(
            key: Key('widget-2'),
            onClick: 'some "messy" onClick',
          ),
          TextArea(
            key: Key('widget-3'),
            onClick: "some 'messy' onClick",
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(
        element1.getAttribute('onclick'),
        equals('some onClick'),
      );

      expect(
        element2.getAttribute('onclick'),
        equals('some "messy" onClick'),
      );

      expect(
        element3.getAttribute('onclick'),
        equals("some 'messy' onClick"),
      );
    });

    test('should set style', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: Key('widget-1'), style: 'some style'),
          TextArea(key: Key('widget-2'), style: 'some "messy" style'),
          TextArea(key: Key('widget-3'), style: "some 'messy' style"),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(element1.getAttribute('style'), equals('some style'));
      expect(element2.getAttribute('style'), equals('some "messy" style'));
      expect(element3.getAttribute('style'), equals("some 'messy' style"));
    });

    test('should set tab index', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            tabIndex: 1,
          ),
          TextArea(
            key: Key('widget-2'),
            tabIndex: 2,
          ),
          TextArea(
            key: Key('widget-3'),
            tabIndex: 3,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(element1.getAttribute('tabindex'), equals('1'));
      expect(element2.getAttribute('tabindex'), equals('2'));
      expect(element3.getAttribute('tabindex'), equals('3'));
    });

    test('should set title', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: Key('widget-1'), title: 'some title'),
          TextArea(key: Key('widget-2'), title: 'some "messy" title'),
          TextArea(key: Key('widget-3'), title: "some 'messy' title"),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(element1.getAttribute('title'), equals('some title'));
      expect(element2.getAttribute('title'), equals('some "messy" title'));
      expect(element3.getAttribute('title'), equals("some 'messy' title"));
    });

    test('should set correct types and markup', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('some-global-key')),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(
        RT_TestBed.rootElement.innerHtml,
        startsWith(
          '<textarea id="some-global-key" '
          'data-${Constants.attrWidgetType}="$TextArea" '
          'data-${Constants.attrRuntimeType}="$TextArea">',
          // Better to check leading part only(without closing tag)
          // Because some tags(e.g img) might don't have a closing tag
          // '</textarea>',
        ),
      );
    });

    test('should set key', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: Key('some-key')),
          TextArea(key: LocalKey('some-local-key')),
          TextArea(key: GlobalKey('some-global-key')),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(element1.id, endsWith('some-key'));
      expect(element2.id, endsWith('some-local-key'));
      expect(element3.id, equals('some-global-key'));
    });
  });
}

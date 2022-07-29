// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  group('meta information tests', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set information', () {
      var context = app!.rootElement;

      context.setMetaInformation(
        informationId: 'a',
        information: MetaInformation(
          name: 'some name',
          content: 'some content',
          charset: 'some charset',
          httpEquiv: 'some http-equiv',
        ),
      );

      var domNode = document.querySelectorAll('meta')[0] as MetaElement;

      expect(domNode.getAttribute('name'), equals('some name'));
      expect(domNode.getAttribute('content'), equals('some content'));
      expect(domNode.getAttribute('charset'), equals('some charset'));
      expect(domNode.getAttribute('http-equiv'), equals('some http-equiv'));
    });

    test('should set only non-null attributes from information', () {
      var context = app!.rootElement;

      context.setMetaInformation(
        informationId: 'a',
        information: MetaInformation(
          name: 'some name',
          content: null,
          charset: 'some charset',
        ),
      );

      var domNode = document.querySelectorAll('meta')[0] as MetaElement;

      expect(domNode.getAttribute('name'), equals('some name'));
      expect(domNode.getAttribute('content'), equals(null));
      expect(domNode.getAttribute('charset'), equals('some charset'));
      expect(domNode.getAttribute('http-equiv'), equals(null));
    });

    test('should override existing information if exists', () {
      var context = app!.rootElement;

      context.setMetaInformation(
        informationId: 'a',
        information: MetaInformation(
          name: 'some name',
          content: 'some content',
          charset: 'some charset',
          httpEquiv: 'some http-equiv',
        ),
      );

      context.setMetaInformation(
        informationId: 'a',
        information: MetaInformation(
          name: 'some updated name',
          content: 'some updated content',
          charset: 'some updated charset',
          httpEquiv: 'some updated http-equiv',
        ),
      );

      var domNode = document.querySelectorAll('meta')[0] as MetaElement;

      expect(domNode.getAttribute('name'), equals('some updated name'));
      expect(domNode.getAttribute('content'), equals('some updated content'));
      expect(domNode.getAttribute('charset'), equals('some updated charset'));
      expect(
        domNode.getAttribute('http-equiv'),
        equals('some updated http-equiv'),
      );
    });

    test('should set additional attributes', () {
      var context = app!.rootElement;

      context.setMetaInformation(
        informationId: 'a',
        information: MetaInformation(
          name: 'some name',
          additionalAttributes: {
            'property': 'og:title',
          },
        ),
      );

      var domNode = document.querySelectorAll('meta')[0] as MetaElement;

      expect(domNode.getAttribute('name'), equals('some name'));
      expect(domNode.getAttribute('property'), equals('og:title'));
    });

    test('should update additional attributes', () {
      var context = app!.rootElement;

      context.setMetaInformation(
        informationId: 'a',
        information: MetaInformation(
          name: 'some name',
          additionalAttributes: {
            'property': 'updated og:title',
          },
        ),
      );

      var domNode = document.querySelectorAll('meta')[0] as MetaElement;

      expect(domNode.getAttribute('name'), equals('some name'));
      expect(domNode.getAttribute('property'), equals('updated og:title'));
    });

    test('should clear additional attributes', () {
      var context = app!.rootElement;

      context.setMetaInformation(
        informationId: 'a',
        information: MetaInformation(
          name: 'some name',
          additionalAttributes: {},
        ),
      );

      var domNode = document.querySelectorAll('meta')[0] as MetaElement;

      expect(domNode.getAttribute('name'), equals('some name'));
      expect(domNode.getAttribute('property'), equals(null));
    });

    test(
      'should clear obsolete parts of existing information while updating',
      () {
        var context = app!.rootElement;

        context.setMetaInformation(
          informationId: 'a',
          information: MetaInformation(
            name: 'some name',
            content: 'some content',
            charset: 'some charset',
            httpEquiv: 'some http-equiv',
          ),
        );

        context.setMetaInformation(
          informationId: 'a',
          information: MetaInformation(
            content: 'some updated content',
            httpEquiv: 'some updated http-equiv',
          ),
        );

        var domNode = document.querySelectorAll('meta')[0] as MetaElement;

        expect(domNode.getAttribute('name'), equals(null));
        expect(domNode.getAttribute('content'), equals('some updated content'));
        expect(domNode.getAttribute('charset'), equals(null));
        expect(
          domNode.getAttribute('http-equiv'),
          equals('some updated http-equiv'),
        );
      },
    );

    test('should clear information', () {
      var context = app!.rootElement;

      context.setMetaInformation(
        informationId: 'a',
        information: MetaInformation(
          name: 'tag one',
        ),
      );

      context.unsetMetaInformation(informationId: 'a');

      expect(document.querySelectorAll('meta').length, equals(0));
    });

    test('should add multiple information tags', () {
      var context = app!.rootElement;

      context.setMetaInformation(
        informationId: 'a',
        information: MetaInformation(
          name: 'tag one',
        ),
      );

      context.setMetaInformation(
        informationId: 'b',
        information: MetaInformation(
          name: 'tag two',
        ),
      );

      var domNode1 = document.querySelectorAll('meta')[0] as MetaElement;
      var domNode2 = document.querySelectorAll('meta')[1] as MetaElement;

      expect(domNode1.name, equals('tag one'));
      expect(domNode2.name, equals('tag two'));
    });
  });

  test('should clear meta information on app dispose', () {
    var app = createTestApp()..start();

    app.rootElement.setMetaInformation(
      informationId: 'a',
      information: MetaInformation(
        name: 'tag one',
      ),
    );

    app.rootElement.setMetaInformation(
      informationId: 'b',
      information: MetaInformation(
        name: 'tag two',
      ),
    );

    expect(document.querySelectorAll('meta').length, equals(2));

    app.stop();

    expect(document.querySelectorAll('meta').length, equals(0));
  });
}

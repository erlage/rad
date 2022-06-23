import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/matchers.dart';
import 'package:rad_test/src/modules/testers.dart';
import 'package:rad_test/src/utilities/test_widget.dart';
import 'package:test/test.dart';

void main() {
  group('re-pumping widgets', () {
    testWidgets('should re-pump widgets', (tester) async {
      await tester.pumpWidget(
        TestWidget(
          roEventUpdate: () => tester.stack.push('update'),
        ),
      );

      await tester.rePumpWidget(
        const TestWidget(),
      );

      expect(tester.stack.popFromStart(), equals('update'));

      expect(tester.stack.canPop(), equals(false));
    });

    testWidgets('should repump multiple widgets', (tester) async {
      await tester.pumpMultipleWidgets([
        TestWidget(
          roEventUpdate: () => tester.stack.push('update 1'),
        ),
        TestWidget(
          roEventUpdate: () => tester.stack.push('update 2'),
        ),
      ]);

      await tester.rePumpMultipleWidgets([
        const TestWidget(),
        const TestWidget(),
      ]);

      expect(tester.stack.popFromStart(), equals('update 1'));
      expect(tester.stack.popFromStart(), equals('update 2'));

      expect(tester.stack.canPop(), equals(false));
    });

    testWidgets('should repump multiple widgets over pump', (tester) async {
      await tester.pumpWidget(
        TestWidget(
          roEventUpdate: () => tester.stack.push('update 1'),
        ),
      );

      await tester.rePumpMultipleWidgets([
        const TestWidget(),
        TestWidget(roEventRender: () => tester.stack.push('render 2')),
      ]);

      expect(tester.stack.popFromStart(), equals('update 1'));
      expect(tester.stack.popFromStart(), equals('render 2'));

      expect(tester.stack.canPop(), equals(false));
    });
  });

  group('findsOneWidget', () {
    testWidgets('finds exactly one widget', (tester) async {
      await tester.pumpWidget(const Text('foo'));

      expect(tester.find.text('foo'), findsOneWidget);
    });

    testWidgets('fails with a descriptive message', (tester) async {
      late TestFailure failure;

      try {
        expect(tester.find.text('foo', skipOffstage: false), findsOneWidget);
      } on TestFailure catch (e) {
        failure = e;
      }

      expect(failure, isNotNull);

      final String? message = failure.message;

      expect(
        message,
        contains('Expected: exactly one matching node in the widget tree\n'),
      );

      expect(
        message,
        contains('Actual: _TextFinder:<zero widgets with text "foo">\n'),
      );

      expect(
        message,
        contains('Which: means none were found but one was expected\n'),
      );
    });
  });

  group('findsNothing', () {
    testWidgets('finds no widgets', (tester) async {
      expect(tester.find.text('foo'), findsNothing);
    });

    testWidgets('fails with a descriptive message', (tester) async {
      await tester.pumpWidget(const Text('foo'));

      late TestFailure failure;
      try {
        expect(tester.find.text('foo', skipOffstage: false), findsNothing);
      } on TestFailure catch (e) {
        failure = e;
      }

      expect(failure, isNotNull);
      final String? message = failure.message;

      expect(
        message,
        contains(
          'Expected: no matching nodes in the widget tree',
        ),
      );

      expect(
        message,
        contains(
          'Actual: _TextFinder:<exactly one widget with text "foo"',
        ),
      );

      expect(
        message,
        contains(
          'Which: means one was found but none were expected',
        ),
      );
    });

    testWidgets('fails with a descriptive message when skipping',
        (tester) async {
      await tester.pumpWidget(const Text('foo'));

      late TestFailure failure;
      try {
        expect(tester.find.text('foo'), findsNothing);
      } on TestFailure catch (e) {
        failure = e;
      }

      expect(failure, isNotNull);
      final String? message = failure.message;

      expect(
        message,
        contains('Expected: no matching nodes in the widget tree\n'),
      );

      expect(
        message,
        contains(
          'Actual: _TextFinder:<exactly one widget with text "foo"',
        ),
      );

      expect(
        message,
        contains('Which: means one was found but none were expected\n'),
      );
    });
  });

  group('tester.find.byWidgetObjectPredicate', () {
    testWidgets('fails with a custom description in the message',
        (tester) async {
      await tester.pumpWidget(const Text('foo'));

      const String customDescription = 'custom description';
      late TestFailure failure;

      try {
        expect(
          tester.find.byRenderElementPredicate(
            (_) => false,
            description: customDescription,
          ),
          findsOneWidget,
        );
      } on TestFailure catch (e) {
        failure = e;
      }

      expect(failure, isNotNull);
      expect(
        failure.message,
        contains(
          'Actual: _WidgetObjectPredicateFinder:<zero widgets with '
          '$customDescription',
        ),
      );
    });
  });

  group('tester.find.byWidgetPredicate', () {
    testWidgets('fails with a custom description in the message',
        (tester) async {
      await tester.pumpWidget(const Text('foo'));

      const String customDescription = 'custom description';
      late TestFailure failure;

      try {
        expect(
          tester.find.byWidgetPredicate(
            (_) => false,
            description: customDescription,
          ),
          findsOneWidget,
        );
      } on TestFailure catch (e) {
        failure = e;
      }

      expect(failure, isNotNull);

      expect(
        failure.message,
        contains(
          'Actual: _WidgetPredicateFinder:<zero widgets with '
          '$customDescription',
        ),
      );
    });
  });

  group('tester.find.descendant', () {
    testWidgets('finds one descendant', (tester) async {
      await tester.pumpWidget(
        const Division(
          children: <Widget>[
            Paragraph(children: fooBarTexts),
          ],
        ),
      );

      expect(
        tester.find.descendant(
          of: tester.find.widgetWithText(Paragraph, 'foo'),
          matching: tester.find.text('bar'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('finds two descendants with different ancestors',
        (tester) async {
      await tester.pumpWidget(
        const Division(
          children: <Widget>[
            Paragraph(children: fooBarTexts),
            Paragraph(children: fooBarTexts),
          ],
        ),
      );

      expect(
        tester.find.descendant(
          of: tester.find.widgetWithText(Paragraph, 'foo'),
          matching: tester.find.text('bar'),
        ),
        findsNWidgets(2),
      );
    });

    testWidgets('fails with a descriptive message', (tester) async {
      await tester.pumpWidget(
        const Division(
          children: <Widget>[
            Paragraph(children: <Text>[Text('foo')]),
            Text('bar'),
          ],
        ),
      );

      late TestFailure failure;
      try {
        expect(
          tester.find.descendant(
            of: tester.find.widgetWithText(Paragraph, 'foo'),
            matching: tester.find.text('bar'),
          ),
          findsOneWidget,
        );
      } on TestFailure catch (e) {
        failure = e;
      }

      expect(failure, isNotNull);

      expect(
        failure.message,
        contains(
          'Actual: _DescendantFinder:<zero widgets with text "bar" that has '
          'ancestor(s) with type "Paragraph" which is an ancestor of text '
          '"foo"',
        ),
      );
    });
  });

  group('tester.find.ancestor', () {
    testWidgets('finds one ancestor', (tester) async {
      await tester.pumpWidget(
        const Row(
          children: <Widget>[
            Division(child: Text('hey there')),
            Column(children: fooBarTexts),
          ],
        ),
      );

      expect(
        tester.find.ancestor(
          of: tester.find.text('bar'),
          matching: tester.find.widgetWithText(Row, 'foo'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('finds two matching ancestors, one descendant', (tester) async {
      await tester.pumpWidget(
        const Row(
          children: <Widget>[
            Row(children: fooBarTexts),
          ],
        ),
      );

      expect(
        tester.find.ancestor(
          of: tester.find.text('bar'),
          matching: tester.find.byType(Row),
        ),
        findsNWidgets(2),
      );
    });

    testWidgets('fails with a descriptive message', (tester) async {
      await tester.pumpWidget(
        const Row(
          children: <Widget>[
            Column(children: <Text>[Text('foo')]),
            Text('bar'),
          ],
        ),
      );

      late TestFailure failure;
      try {
        expect(
          tester.find.ancestor(
            of: tester.find.text('bar'),
            matching: tester.find.widgetWithText(Column, 'foo'),
          ),
          findsOneWidget,
        );
      } on TestFailure catch (e) {
        failure = e;
      }

      expect(failure, isNotNull);
      expect(
        failure.message,
        contains(
          'Actual: _AncestorFinder:<zero widgets with type "Column" which is '
          'an ancestor of text "foo" which is an ancestor of text "bar"',
        ),
      );
    });

    testWidgets('Root not matched by default', (tester) async {
      await tester.pumpWidget(
        const Row(
          children: <Widget>[
            Column(children: fooBarTexts),
          ],
        ),
      );

      expect(
        tester.find.ancestor(
          of: tester.find.byType(Column),
          matching: tester.find.widgetWithText(Column, 'foo'),
        ),
        findsNothing,
      );
    });

    testWidgets('Match the root', (tester) async {
      await tester.pumpWidget(
        const Row(
          children: <Widget>[
            Column(children: fooBarTexts),
          ],
        ),
      );

      expect(
        tester.find.descendant(
          of: tester.find.byType(Column),
          matching: tester.find.widgetWithText(Column, 'foo'),
          matchRoot: true,
        ),
        findsOneWidget,
      );
    });
  });

  group('skip flag', () {
    testWidgets(
      'should skip this test',
      (tester) {
        expect(false, equals(true));
      },
      skip: true,
    );
  });

  group(
    'skip flag on group',
    () {
      testWidgets('should skip this test', (tester) {
        expect(false, equals(true));
      });
    },
    skip: true,
  );
}

const List<Widget> fooBarTexts = <Text>[
  Text('foo'),
  Text('bar'),
];

class Row extends Division {
  const Row({super.children});
}

class Column extends Paragraph {
  const Column({super.children});
}

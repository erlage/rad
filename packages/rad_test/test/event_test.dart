import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/testers.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('dispatchEvent', () {
    testWidgets('should dispatch event', (tester) async {
      await tester.pumpWidget(
        Division(
          onClick: (_) => tester.stack.push('fired'),
          child: const Text('foo'),
        ),
      );

      await tester.dispatchEvent(
        event: Event('click'),
        finder: tester.find.widgetWithText(Division, 'foo'),
      );

      expect(tester.stack.popFromStart(), equals('fired'));
      expect(tester.stack.canPop(), equals(false));
    });

    testWidgets('should throw if matched n-widgets by default', (tester) async {
      await tester.pumpWidget(
        const Span(
          child: Span(
            child: Division(
              child: Text('foo'),
            ),
          ),
        ),
      );

      await tester.dispatchEvent(
        event: Event('change'),
        finder: tester.find.ancestor(
          of: tester.find.byType(Division),
          matching: tester.find.widgetWithText(Span, 'foo'),
        ),
      );

      expect(
        tester.takeException().toString(),
        contains('Found multiple matching widgets with the finder'),
      );
    });

    testWidgets('should dispatch to n-widgets', (tester) async {
      await tester.pumpWidget(
        Span(
          onClick: (_) => tester.stack.push('fired-parent'),
          child: Span(
            onClick: (e) {
              tester.stack.push('fired-child');

              // if event bubbles, it's corrupt our test stack
              e.stopImmediatePropagation();
            },
            child: const Division(
              child: Text('foo'),
            ),
          ),
        ),
      );

      await tester.dispatchEvent(
        event: Event('click'),
        finder: tester.find.ancestor(
          of: tester.find.byType(Division),
          matching: tester.find.widgetWithText(Span, 'foo'),
        ),
        dispatchToMultipleNodes: true,
      );

      expect(tester.stack.popFromStart(), equals('fired-child'));
      expect(tester.stack.popFromStart(), equals('fired-parent'));

      expect(tester.stack.canPop(), equals(false));
    });
  });

  group('click', () {
    testWidgets('should dispatch event', (tester) async {
      await tester.pumpWidget(
        Span(
          onClick: (_) => tester.stack.push('fired'),
          child: const Text('foo'),
        ),
      );

      await tester.click(tester.find.widgetWithText(Span, 'foo'));

      expect(tester.stack.popFromStart(), equals('fired'));
      expect(tester.stack.canPop(), equals(false));
    });

    testWidgets('should dispatch to n-widgets', (tester) async {
      await tester.pumpWidget(
        Span(
          onClick: (_) => tester.stack.push('fired-parent'),
          child: Span(
            onClick: (e) {
              tester.stack.push('fired-child');

              // if event bubbles, it's corrupt our test stack
              e.stopImmediatePropagation();
            },
            child: const Division(
              child: Text('foo'),
            ),
          ),
        ),
      );

      await tester.click(
        tester.find.ancestor(
          of: tester.find.byType(Division),
          matching: tester.find.widgetWithText(Span, 'foo'),
        ),
        dispatchToMultipleNodes: true,
      );

      expect(tester.stack.popFromStart(), equals('fired-child'));
      expect(tester.stack.popFromStart(), equals('fired-parent'));

      expect(tester.stack.canPop(), equals(false));
    });
  });
}

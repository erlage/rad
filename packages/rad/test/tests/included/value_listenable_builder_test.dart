// ignore_for_file: avoid_types_on_closure_parameters, unawaited_futures

import '../../test_imports.dart' hide Text;
import '../../mocks/test_framework.dart';

// -----------------------------------------------------------------------
// Repo: https://github.com/flutter/flutter/
// Path: packages/flutter/test/widgets/value_listenable_builder_test.dart
// -----------------------------------------------------------------------
//
// How to update this file:
//
//    - Paste new source below double dotted lines
//    - Comment out imports from newly pasted source
//    - (optional) Wrap all tests under group-by for sanity
//
// -----------------------------------------------------------------------
// -----------------------------------------------------------------------

// Copyright 2014 The Flutter Authors. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_test/flutter_test.dart';

void main() {
  late SpyStringValueNotifier valueListenable;
  late Widget textBuilderUnderTest;

  Widget builderForValueListenable(
    ValueListenable<String?> valueListenable,
  ) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ValueListenableBuilder<String?>(
        valueListenable: valueListenable,
        builder: (BuildContext context, String? value, Widget? child) {
          if (value == null) return const Placeholder();
          return Text(value);
        },
      ),
    );
  }

  group('Value Listenable builder tests', () {
    setUp(() {
      valueListenable = SpyStringValueNotifier(null);
      textBuilderUnderTest = builderForValueListenable(valueListenable);
    });

    testWidgets('Null value is ok', (WidgetTester tester) async {
      await tester.pumpWidget(textBuilderUnderTest);

      expect(find.byType(Placeholder), findsOneWidget);
    });

    testWidgets('Widget builds with initial value',
        (WidgetTester tester) async {
      valueListenable = SpyStringValueNotifier('Bachman');

      await tester.pumpWidget(builderForValueListenable(valueListenable));

      expect(find.text('Bachman'), findsOneWidget);
    });

    testWidgets('Widget updates when value changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(textBuilderUnderTest);

      valueListenable.value = 'Gilfoyle';
      await tester.pump();
      expect(find.text('Gilfoyle'), findsOneWidget);

      valueListenable.value = 'Dinesh';
      await tester.pump();
      expect(find.text('Gilfoyle'), findsNothing);
      expect(find.text('Dinesh'), findsOneWidget);
    });

    testWidgets('Can change listenable', (WidgetTester tester) async {
      await tester.pumpWidget(textBuilderUnderTest);

      valueListenable.value = 'Gilfoyle';
      await tester.pump();
      expect(find.text('Gilfoyle'), findsOneWidget);

      final ValueListenable<String?> differentListenable =
          SpyStringValueNotifier('Hendricks');

      await tester.pumpWidget(builderForValueListenable(differentListenable));

      expect(find.text('Gilfoyle'), findsNothing);
      expect(find.text('Hendricks'), findsOneWidget);
    });

    testWidgets('Stops listening to old listenable after changing listenable',
        (WidgetTester tester) async {
      await tester.pumpWidget(textBuilderUnderTest);

      valueListenable.value = 'Gilfoyle';
      await tester.pump();
      expect(find.text('Gilfoyle'), findsOneWidget);

      final ValueListenable<String?> differentListenable =
          SpyStringValueNotifier('Hendricks');

      await tester.pumpWidget(builderForValueListenable(differentListenable));

      expect(find.text('Gilfoyle'), findsNothing);
      expect(find.text('Hendricks'), findsOneWidget);

      // Change value of the (now) disconnected listenable.
      valueListenable.value = 'Big Head';

      expect(find.text('Gilfoyle'), findsNothing);
      expect(find.text('Big Head'), findsNothing);
      expect(find.text('Hendricks'), findsOneWidget);
    });

    testWidgets('Self-cleans when removed', (WidgetTester tester) async {
      await tester.pumpWidget(textBuilderUnderTest);

      valueListenable.value = 'Gilfoyle';
      await tester.pump();
      expect(find.text('Gilfoyle'), findsOneWidget);

      await tester.pumpWidget(const Placeholder());

      expect(find.text('Gilfoyle'), findsNothing);
      expect(valueListenable.hasListeners, false);
    });
  });
}

class SpyStringValueNotifier extends ValueNotifier<String?> {
  SpyStringValueNotifier(String? initialValue) : super(initialValue);

  /// Override for test visibility only.
  @override
  bool get hasListeners => super.hasListeners;
}

// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: prefer_asserts_with_message

// parts of flutter test framework that we've to mock in order to run tests
// that we had copied from flutter sdk.

import '../test_imports.dart';

typedef WidgetTesterCallback = Future<void> Function(WidgetTester widgetTester);

enum TextDirection {
  rtl,
  ltr,
}

class GlobalKey extends Key {
  const GlobalKey([String value = 'not-set']) : super(value);
}

class Column extends Division {
  const Column({
    List<Widget>? children,
  }) : super(
          children: children,
        );
}

class Placeholder extends Division {
  const Placeholder();
}

class Directionality extends Division {
  const Directionality({
    TextDirection? textDirection,
    required Widget child,
  }) : super(
          child: child,
        );
}

class Text extends Division {
  const Text(
    String text, {
    TextDirection? textDirection,
  }) : super(
          innerText: text,
        );
}

class WidgetTester {
  final RT_AppRunner app;

  WidgetTester(this.app);

  Future<void> pump([
    Duration? duration,
  ]) async {
    await Future.delayed(duration ?? Duration(milliseconds: 100));
  }

  Future<void> pumpAndSettle([
    Duration? duration,
  ]) async {
    await Future.delayed(duration ?? Duration(milliseconds: 100));
  }

  Future<void> pumpWidget(
    Widget widget, [
    Duration? duration,
  ]) async {
    await app.updateChildren(
      widgets: [widget],
      parentRenderElement: app.appRenderElement,
      updateType: UpdateType.setState,
    );

    await Future.delayed(duration ?? Duration(milliseconds: 100));
  }

  dynamic takeException() {}
}

void testWidgets(String description, WidgetTesterCallback callback) {
  RT_AppRunner? app;

  try {
    test(description, () async {
      app = createTestApp()..start();

      var widgetTester = WidgetTester(app!);

      await callback(widgetTester);
    });
  } catch (e) {
    rethrow;
  } finally {
    app?.stop();
  }
}

Finder text(
  String text, {
  bool findRichText = false,
  bool skipOffstage = true,
}) {
  return _TextFinder(
    text,
    findRichText: findRichText,
    skipOffstage: skipOffstage,
  );
}

class _TextFinder extends _MatchTextFinder {
  _TextFinder(
    this.text, {
    super.findRichText,
    super.skipOffstage,
  });

  final String text;

  @override
  String get description => 'text "$text"';

  @override
  bool matchesText(String textToMatch) {
    return textToMatch == text;
  }
}

abstract class _MatchTextFinder extends MatchFinder {
  _MatchTextFinder({
    this.findRichText = false,
    super.skipOffstage,
  });

  final bool findRichText;

  bool matchesText(String textToMatch);

  @override
  bool matches(RenderElement candidate) {
    var domNode = candidate.domNode;

    if (null == domNode) {
      return false;
    }

    return matchesText(domNode.children.isNotEmpty ? '-' : domNode.innerText);
  }
}

abstract class MatchFinder extends Finder {
  MatchFinder({super.skipOffstage});

  bool matches(RenderElement candidate);

  @override
  Iterable<RenderElement> apply(Iterable<RenderElement> candidates) {
    return candidates.where(matches);
  }
}

abstract class Finder {
  Finder({this.skipOffstage = true});

  String get description;

  Iterable<RenderElement> apply(Iterable<RenderElement> candidates);

  final bool skipOffstage;

  Iterable<RenderElement> get allCandidates {
    var rootElement = ServicesRegistry.instance
        .getServices(
          RT_TestBed.rootRenderElement,
        )
        .rootElement;

    final elements = <RenderElement>[];

    void traverser(RenderElement element) {
      elements.add(element);

      element.traverseChildElements(traverser);
    }

    rootElement.traverseChildElements(traverser);

    return elements;
  }

  Iterable<RenderElement>? _cachedResult;

  Iterable<RenderElement> evaluate() {
    final Iterable<RenderElement> result =
        _cachedResult ?? apply(allCandidates);
    _cachedResult = null;
    return result;
  }

  bool precache() {
    assert(_cachedResult == null);
    final Iterable<RenderElement> result = apply(allCandidates);
    if (result.isNotEmpty) {
      _cachedResult = result;
      return true;
    }
    _cachedResult = null;
    return false;
  }

  @override
  String toString() {
    final String additional =
        skipOffstage ? ' (ignoring offstage widgets)' : '';
    final List<RenderElement> widgets = evaluate().toList();
    final int count = widgets.length;
    if (count == 0) return 'zero widgets with $description$additional';
    if (count == 1) {
      return 'exactly one widget with $description$additional: ${widgets.single}';
    }
    if (count < 4) {
      return '$count widgets with $description$additional: $widgets';
    }

    return '$count widgets with $description$additional: ${widgets[0]}, ${widgets[1]}, ${widgets[2]}, ...';
  }
}

const Matcher findsOneWidget = _FindsWidgetMatcher(1, 1);

Matcher findsNWidgets(int n) => _FindsWidgetMatcher(n, n);

const Matcher findsNothing = _FindsWidgetMatcher(null, 0);

Finder byType(
  Type type, {
  bool skipOffstage = true,
}) =>
    _WidgetTypeFinder(type, skipOffstage: skipOffstage);

/// Some frequently used widget [Finder]s.
const CommonFinders find = CommonFinders._();

/// Provides lightweight syntax for getting frequently used widget [Finder]s.
///
/// This class is instantiated once, as [find].
class CommonFinders {
  const CommonFinders._();

  Finder text(
    String text, {
    bool findRichText = false,
    bool skipOffstage = true,
  }) {
    return _TextFinder(
      text,
      findRichText: findRichText,
      skipOffstage: skipOffstage,
    );
  }

  Finder byType(
    Type type, {
    bool skipOffstage = true,
  }) =>
      _WidgetTypeFinder(
        type,
        skipOffstage: skipOffstage,
      );
}

class _WidgetTypeFinder extends MatchFinder {
  _WidgetTypeFinder(this.widgetType, {super.skipOffstage});

  final Type widgetType;

  @override
  String get description => 'type "$widgetType"';

  @override
  bool matches(RenderElement candidate) {
    return candidate.widget.runtimeType == widgetType;
  }
}

class _FindsWidgetMatcher extends Matcher {
  const _FindsWidgetMatcher(this.min, this.max);

  final int? min;
  final int? max;

  @override
  bool matches(covariant Finder finder, Map<dynamic, dynamic> matchState) {
    assert(min != null || max != null);
    assert(min == null || max == null || min! <= max!);
    matchState[Finder] = finder;
    int count = 0;
    final Iterator<RenderElement> iterator = finder.evaluate().iterator;
    if (min != null) {
      while (count < min! && iterator.moveNext()) {
        count += 1;
      }
      if (count < min!) {
        return false;
      }
    }
    if (max != null) {
      while (count <= max! && iterator.moveNext()) {
        count += 1;
      }
      if (count > max!) {
        return false;
      }
    }
    return true;
  }

  @override
  Description describe(Description description) {
    assert(min != null || max != null);
    if (min == max) {
      if (min == 1) {
        return description.add('exactly one matching node in the widget tree');
      }
      return description.add('exactly $min matching nodes in the widget tree');
    }
    if (min == null) {
      if (max == 0) {
        return description.add('no matching nodes in the widget tree');
      }
      if (max == 1) {
        return description.add('at most one matching node in the widget tree');
      }
      return description.add('at most $max matching nodes in the widget tree');
    }
    if (max == null) {
      if (min == 1) {
        return description.add('at least one matching node in the widget tree');
      }
      return description.add('at least $min matching nodes in the widget tree');
    }
    return description.add(
        'between $min and $max matching nodes in the widget tree (inclusive)');
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map<dynamic, dynamic> matchState,
    bool verbose,
  ) {
    final Finder finder = matchState[Finder] as Finder;
    final int count = finder.evaluate().length;
    if (count == 0) {
      assert(min != null && min! > 0);
      if (min == 1 && max == 1) {
        return mismatchDescription
            .add('means none were found but one was expected');
      }
      return mismatchDescription
          .add('means none were found but some were expected');
    }
    if (max == 0) {
      if (count == 1) {
        return mismatchDescription
            .add('means one was found but none were expected');
      }
      return mismatchDescription
          .add('means some were found but none were expected');
    }
    if (min != null && count < min!) {
      return mismatchDescription.add('is not enough');
    }
    assert(max != null && count > min!);
    return mismatchDescription.add('is too many');
  }
}

void expectSync(
  dynamic actual,
  dynamic matcher, {
  String? reason,
}) {
  expect(actual, matcher, reason: reason);
}

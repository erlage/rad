import 'package:meta/meta.dart';

import 'package:rad_test/src/common/types.dart';
import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/all_elements.dart';
import 'package:rad_test/src/modules/widget_tester.dart';
import 'package:rad_test/src/runner/app_runner.dart';

/// Provides lightweight syntax for getting frequently used widget [Finder]s.
///
/// This class is instantiated once, as [WidgetTester.find].
///
class CommonFinders {
  final AppRunner _app;

  const CommonFinders(this._app);

  /// Finds [Text widgets containing string equal to the `text` argument.
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are Offstage or that are from inactive [Route]s.
  ///
  /// ## Example
  ///
  /// ```dart
  /// expect(tester.find.text('Back'), findsOneWidget);
  /// ```
  ///
  Finder text(
    String text, {
    bool skipOffstage = true,
  }) {
    return _TextFinder(
      text: text,
      appContext: _app.appContext,
      skipOffstage: skipOffstage,
    );
  }

  /// Finds [Text] widgets which contain the given `pattern` argument.
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are Offstage or that are from inactive [Route]s.
  ///
  /// ## Example
  ///
  /// ```dart
  /// expect(tester.find.textContain('Back'), findsOneWidget);
  /// expect(tester.find.textContain(RegExp(r'(\w+)')), findsOneWidget);
  /// ```
  ///
  Finder textContaining(
    Pattern pattern, {
    bool skipOffstage = true,
  }) {
    return _TextContainingFinder(
      pattern: pattern,
      appContext: _app.appContext,
      skipOffstage: skipOffstage,
    );
  }

  /// Looks for widgets that contain a [Text] descendant with `text`
  /// in it.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Suppose you have a button with text 'Update' in it:
  /// Button(
  ///   child: Text('Update')
  /// )
  ///
  /// // You can find and click on it like this:
  /// tester.click(tester.find.widgetWithText(Button, 'Update'));
  /// ```
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are Offstage or that are from inactive [Route]s.
  ///
  Finder widgetWithText(
    Type widgetType,
    String text, {
    bool skipOffstage = true,
  }) {
    return ancestor(
      of: this.text(text, skipOffstage: skipOffstage),
      matching: byType(widgetType, skipOffstage: skipOffstage),
    );
  }

  /// Finds widgets by searching for one with a particular [Key].
  ///
  /// ## Example
  ///
  /// ```dart
  /// expect(tester.find.byKey(backKey), findsOneWidget);
  /// ```
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are Offstage or that are from inactive [Route]s.
  ///
  Finder byKey(
    Key key, {
    bool skipOffstage = true,
  }) =>
      _KeyFinder(
        key: key,
        appContext: _app.appContext,
        skipOffstage: skipOffstage,
      );

  /// Finds widgets by searching for widgets implementing a particular type.
  ///
  /// This matcher accepts subtypes. For example a
  /// `bySubtype<StatefulWidget>()` will find any stateful widget.
  ///
  /// ## Example
  ///
  /// ```dart
  /// expect(tester.find.bySubtype<Span>(), findsOneWidget);
  /// ```
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are Offstage or that are from inactive [Route]s.
  ///
  /// See also:
  /// * [byType], which does not do subtype tests.
  ///
  Finder bySubtype<T extends Widget>({
    bool skipOffstage = true,
  }) =>
      _WidgetSubtypeFinder<T>(
        appContext: _app.appContext,
        skipOffstage: skipOffstage,
      );

  /// Finds widgets by searching for widgets with a particular type.
  ///
  /// This does not do subclass tests, so for example
  /// `byType(StatefulWidget)` will never find anything since that's
  /// an abstract class.
  ///
  /// The `type` argument must be a subclass of [Widget].
  ///
  /// ## Example
  ///
  /// ```dart
  /// expect(tester.find.byType(Span), findsOneWidget);
  /// ```
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are Offstage or that are from inactive [Route]s.
  ///
  /// See also:
  /// * [bySubtype], which allows subtype tests.
  ///
  Finder byType(
    Type type, {
    bool skipOffstage = true,
  }) =>
      _WidgetTypeFinder(
        widgetType: type,
        appContext: _app.appContext,
        skipOffstage: skipOffstage,
      );

  /// Finds widgets whose current widget is the instance given by the
  /// argument.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Suppose you have a button created like this:
  /// Widget myButton = Button(
  ///   child: Text('Update')
  /// );
  ///
  /// // You can find and tap on it like this:
  /// tester.tap(find.byWidget(myButton));
  /// ```
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are Offstage or that are from inactive [Route]s.
  ///
  Finder byWidget(
    Widget widget, {
    bool skipOffstage = true,
  }) =>
      _WidgetFinder(
        widget: widget,
        appContext: _app.appContext,
        skipOffstage: skipOffstage,
      );

  /// Finds widgets using a widget [predicate].
  ///
  /// ## Example
  ///
  /// ```dart
  /// expect(tester.find.byWidgetPredicate(
  ///   (Widget widget) => widget is Text && widget.text == 'Back',
  ///   description: 'widget with text "Back"',
  /// ), findsOneWidget);
  /// ```
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are Offstage or that are from inactive [Route]s.
  ///
  Finder byWidgetPredicate(
    WidgetPredicate predicate, {
    String? description,
    bool skipOffstage = true,
  }) {
    return _WidgetPredicateFinder(
      predicate: predicate,
      appContext: _app.appContext,
      description: description,
      skipOffstage: skipOffstage,
    );
  }

  /// Finds widgets using an widget object [predicate].
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are Offstage or that are from inactive [Route]s.
  ///
  Finder byWidgetObjectPredicate(
    WidgetObjectPredicate predicate, {
    String? description,
    bool skipOffstage = true,
  }) {
    return _WidgetObjectPredicateFinder(
      predicate: predicate,
      appContext: _app.appContext,
      description: description,
      skipOffstage: skipOffstage,
    );
  }

  /// Finds widgets that are descendants of the [of] parameter and that match
  /// the [matching] parameter.
  ///
  /// ## Example
  ///
  /// ```dart
  /// expect(tester.find.descendant(
  ///   of: find.widgetWithText(Span, 'label_1'), matching: find.text('value_1')
  /// ), findsOneWidget);
  /// ```
  ///
  /// If the [matchRoot] argument is true then the widget(s) specified by [of]
  /// will be matched along with the descendants.
  ///
  /// If the [skipOffstage] argument is true (the default), then nodes that are
  /// Offstage or that are from inactive [Route]s are skipped.
  ///
  Finder descendant({
    required Finder of,
    required Finder matching,
    bool matchRoot = false,
    bool skipOffstage = true,
  }) {
    return _DescendantFinder(
      ancestor: of,
      descendant: matching,
      appContext: _app.appContext,
      matchRoot: matchRoot,
      skipOffstage: skipOffstage,
    );
  }

  /// Finds widgets that are ancestors of the [of] parameter and that match
  /// the [matching] parameter.
  ///
  /// If the [matchRoot] argument is true then the widget(s) specified by [of]
  /// will be matched along with the ancestors.
  ///
  Finder ancestor({
    required Finder of,
    required Finder matching,
    bool matchRoot = false,
  }) {
    return _AncestorFinder(
      descendant: of,
      ancestor: matching,
      appContext: _app.appContext,
      matchRoot: matchRoot,
    );
  }
}

/// Searches a widget tree and returns nodes that match a particular
/// pattern.
///
abstract class Finder with ServicesResolver {
  /// Current's app build context.
  ///
  final BuildContext appContext;

  /// Services instance associated with current app.
  ///
  Services get services => resolveServices(appContext);

  /// Initializes a Finder. Used by subclasses to initialize the [skipOffstage]
  /// property.
  ///
  Finder({
    required this.appContext,
    this.skipOffstage = true,
  });

  /// Describes what the finder is looking for. The description should be
  /// a brief English noun phrase describing the finder's pattern.
  ///
  String get description;

  /// Returns all the elements in the given list that match this
  /// finder's pattern.
  ///
  /// When implementing your own Finders that inherit directly from
  /// [Finder], this is the main method to override. If your finder
  /// can efficiently be described just in terms of a predicate
  /// function, consider extending [MatchFinder] instead.
  ///
  Iterable<WidgetObject> apply(Iterable<WidgetObject> candidates);

  /// Whether this finder skips nodes that are offstage.
  ///
  /// If this is true, then the widgets that are not visible are skipped.
  /// This skips offstage children of Offstage widgets, as well as children
  /// of inactive [Route]s.
  ///
  final bool skipOffstage;

  /// Returns all the [WidgetObject]s that will be considered by this finder.
  ///
  /// See [collectAllWidgetObjectsFrom].
  ///
  @protected
  Iterable<WidgetObject> get allCandidates {
    return collectAllWidgetObjectsFrom(
      services.walker.getWidgetObject(appContext)!,
      skipOffstage: skipOffstage,
    );
  }

  Iterable<WidgetObject>? _cachedResult;

  /// Returns the current result. If [precache] was called and returned true,
  /// this will cheaply return the result that was computed then. Otherwise, it
  /// creates a new iterable to compute the answer.
  ///
  /// Calling this clears the cache from [precache].
  ///
  Iterable<WidgetObject> evaluate() {
    final Iterable<WidgetObject> result = _cachedResult ?? apply(allCandidates);
    _cachedResult = null;
    return result;
  }

  /// Attempts to evaluate the finder. Returns whether any elements in the tree
  /// matched the finder. If any did, then the result is cached and can be
  /// obtained from [evaluate].
  ///
  /// If this returns true, you must call [evaluate] before you call [precache]
  /// again.
  ///
  bool precache() {
    // ignore: prefer_asserts_with_message
    assert(_cachedResult == null);
    final Iterable<WidgetObject> result = apply(allCandidates);
    if (result.isNotEmpty) {
      _cachedResult = result;
      return true;
    }
    _cachedResult = null;
    return false;
  }

  /// Returns a variant of this finder that only matches the first element
  /// matched by this finder.
  ///
  Finder get first => _FirstFinder(parent: this, appContext: appContext);

  /// Returns a variant of this finder that only matches the last element
  /// matched by this finder.
  ///
  Finder get last => _LastFinder(parent: this, appContext: appContext);

  /// Returns a variant of this finder that only matches the element at the
  /// given index matched by this finder.
  ///
  Finder at(int index) => _IndexFinder(
        parent: this,
        index: index,
        appContext: appContext,
      );

  @override
  String toString() {
    final String additional = skipOffstage ? ' (ignoring offstage)' : '';

    final List<WidgetObject> widgets = evaluate().toList();

    final int count = widgets.length;

    if (count == 0) return 'zero widgets with $description$additional';

    if (count == 1) {
      return 'exactly one widget with $description$additional: '
          '${widgets.single}';
    }

    if (count < 4) {
      return '$count widgets with $description$additional: $widgets';
    }

    return '$count widgets with $description$additional: ${widgets[0]}, '
        '${widgets[1]}, ${widgets[2]}, ...';
  }
}

/// Applies additional filtering against a [parent] [Finder].
///
abstract class ChainedFinder extends Finder {
  /// Create a Finder chained against the candidates of another [Finder].
  ///
  ChainedFinder({required this.parent, required super.appContext});

  /// Another [Finder] that will run first.
  ///
  final Finder parent;

  /// Return another [Iterable] when given an [Iterable] of candidates from a
  /// parent [Finder].
  ///
  /// This is the method to implement when subclassing [ChainedFinder].
  ///
  Iterable<WidgetObject> filter(Iterable<WidgetObject> parentCandidates);

  @override
  Iterable<WidgetObject> apply(Iterable<WidgetObject> candidates) {
    return filter(parent.apply(candidates));
  }

  @override
  Iterable<WidgetObject> get allCandidates => parent.allCandidates;
}

class _FirstFinder extends ChainedFinder {
  _FirstFinder({required super.parent, required super.appContext});

  @override
  String get description => '${parent.description} (ignoring all but first)';

  @override
  Iterable<WidgetObject> filter(Iterable<WidgetObject> parentCandidates) sync* {
    yield parentCandidates.first;
  }
}

class _LastFinder extends ChainedFinder {
  _LastFinder({required super.parent, required super.appContext});

  @override
  String get description => '${parent.description} (ignoring all but last)';

  @override
  Iterable<WidgetObject> filter(Iterable<WidgetObject> parentCandidates) sync* {
    yield parentCandidates.last;
  }
}

class _IndexFinder extends ChainedFinder {
  _IndexFinder({
    required this.index,
    required super.parent,
    required super.appContext,
  });

  final int index;

  @override
  String get description =>
      '${parent.description} (ignoring all but index $index)';

  @override
  Iterable<WidgetObject> filter(Iterable<WidgetObject> parentCandidates) sync* {
    yield parentCandidates.elementAt(index);
  }
}

/// Searches a widget tree and returns nodes that match a particular
/// pattern.
///
abstract class MatchFinder extends Finder {
  /// Initializes a predicate-based Finder. Used by subclasses to initialize the
  /// [skipOffstage] property.
  ///
  MatchFinder({required super.appContext, super.skipOffstage});

  /// Returns true if the given element matches the pattern.
  ///
  /// When implementing your own MatchFinder, this is the main method to
  /// override.
  ///
  bool matches(WidgetObject candidate);

  @override
  Iterable<WidgetObject> apply(Iterable<WidgetObject> candidates) {
    return candidates.where(matches);
  }
}

abstract class _MatchTextFinder extends MatchFinder {
  _MatchTextFinder({
    required super.appContext,
    super.skipOffstage,
  });

  bool matchesText(String textToMatch);

  @override
  bool matches(WidgetObject candidate) {
    final Widget widget = candidate.widget;

    return _matchesText(widget);
  }

  bool _matchesText(Widget widget) {
    if (widget is Text) {
      return matchesText(widget.text);
    }

    return false;
  }
}

class _TextFinder extends _MatchTextFinder {
  _TextFinder({
    required this.text,
    required super.appContext,
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

class _TextContainingFinder extends _MatchTextFinder {
  _TextContainingFinder({
    required this.pattern,
    required super.appContext,
    super.skipOffstage,
  });

  final Pattern pattern;

  @override
  String get description => 'text containing $pattern';

  @override
  bool matchesText(String textToMatch) {
    return textToMatch.contains(pattern);
  }
}

class _KeyFinder extends MatchFinder {
  _KeyFinder({
    required this.key,
    required super.appContext,
    super.skipOffstage,
  });

  final Key key;

  @override
  String get description => 'key $key';

  @override
  bool matches(WidgetObject candidate) {
    return candidate.context.key == key;
  }
}

class _WidgetSubtypeFinder<T extends Widget> extends MatchFinder {
  _WidgetSubtypeFinder({required super.appContext, super.skipOffstage});

  @override
  String get description => 'is "$T"';

  @override
  bool matches(WidgetObject candidate) {
    return candidate.widget is T;
  }
}

class _WidgetTypeFinder extends MatchFinder {
  _WidgetTypeFinder({
    required this.widgetType,
    required super.appContext,
    super.skipOffstage,
  });

  final Type widgetType;

  @override
  String get description => 'type "$widgetType"';

  @override
  bool matches(WidgetObject candidate) {
    return candidate.widget.runtimeType == widgetType;
  }
}

class _WidgetFinder extends MatchFinder {
  _WidgetFinder({
    required this.widget,
    required super.appContext,
    super.skipOffstage,
  });

  final Widget widget;

  @override
  String get description => 'the given widget ($widget)';

  @override
  bool matches(WidgetObject candidate) {
    return candidate.widget == widget;
  }
}

class _WidgetPredicateFinder extends MatchFinder {
  _WidgetPredicateFinder({
    required this.predicate,
    String? description,
    required super.appContext,
    super.skipOffstage,
  }) : _description = description;

  final WidgetPredicate predicate;
  final String? _description;

  @override
  String get description =>
      _description ?? 'widget matching predicate ($predicate)';

  @override
  bool matches(WidgetObject candidate) {
    return predicate(candidate.widget);
  }
}

class _WidgetObjectPredicateFinder extends MatchFinder {
  _WidgetObjectPredicateFinder({
    required this.predicate,
    String? description,
    required super.appContext,
    super.skipOffstage,
  }) : _description = description;

  final WidgetObjectPredicate predicate;
  final String? _description;

  @override
  String get description =>
      _description ?? 'element matching predicate ($predicate)';

  @override
  bool matches(WidgetObject candidate) {
    return predicate(candidate);
  }
}

class _DescendantFinder extends Finder {
  _DescendantFinder({
    required this.ancestor,
    required this.descendant,
    this.matchRoot = false,
    super.skipOffstage,
    required super.appContext,
  });

  final Finder ancestor;
  final Finder descendant;
  final bool matchRoot;

  @override
  String get description {
    if (matchRoot) {
      return '${descendant.description} in the subtree(s) beginning with '
          '${ancestor.description}';
    }

    return '${descendant.description} that has ancestor(s) with '
        '${ancestor.description}';
  }

  @override
  Iterable<WidgetObject> apply(Iterable<WidgetObject> candidates) {
    return candidates.where(
      (widgetObject) => descendant.evaluate().contains(
            widgetObject,
          ),
    );
  }

  @override
  Iterable<WidgetObject> get allCandidates {
    final Iterable<WidgetObject> ancestorElements = ancestor.evaluate();

    final List<WidgetObject> candidates = ancestorElements
        .expand<WidgetObject>(
          (widgetObject) => collectAllWidgetObjectsFrom(
            widgetObject,
            skipOffstage: skipOffstage,
          ),
        )
        .toSet()
        .toList();

    if (matchRoot) {
      candidates.insertAll(0, ancestorElements);
    }

    return candidates;
  }
}

class _AncestorFinder extends Finder {
  _AncestorFinder({
    required this.ancestor,
    required this.descendant,
    this.matchRoot = false,
    required super.appContext,
  }) : super(skipOffstage: false);

  final Finder ancestor;
  final Finder descendant;
  final bool matchRoot;

  @override
  String get description {
    if (matchRoot) {
      return 'ancestor ${ancestor.description} beginning with '
          '${descendant.description}';
    }

    return '${ancestor.description} which is an ancestor of '
        '${descendant.description}';
  }

  @override
  Iterable<WidgetObject> apply(Iterable<WidgetObject> candidates) {
    return candidates.where((element) => ancestor.evaluate().contains(element));
  }

  @override
  Iterable<WidgetObject> get allCandidates {
    final List<WidgetObject> candidates = <WidgetObject>[];
    for (final WidgetObject root in descendant.evaluate()) {
      final List<WidgetObject> ancestors = <WidgetObject>[];

      if (matchRoot) {
        ancestors.add(root);
      }

      BuildContext parent = root.context.parent;

      while (!parent.isRoot) {
        var parentObject = services.walker.getWidgetObject(parent);

        if (null == parentObject || parentObject.widget is TestAppRootWidget) {
          break;
        }

        ancestors.add(parentObject);
        parent = parentObject.context.parent;
      }

      candidates.addAll(ancestors);
    }
    return candidates;
  }
}

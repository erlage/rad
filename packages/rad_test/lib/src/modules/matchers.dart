// ignore_for_file: prefer_asserts_with_message

import 'package:test/expect.dart';

import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/finders.dart';

/// Asserts that the [Finder] matches no widgets in the widget tree.
///
/// ## Example
///
/// ```dart
/// expect(tester.find.text('Save'), findsNothing);
/// ```
///
/// See also:
///
///  * [findsWidgets], when you want the finder to find one or more widgets.
///  * [findsOneWidget], when you want the finder to find exactly one widget.
///  * [findsNWidgets], when you want the finder to find a specific number of
/// widgets.
///
const Matcher findsNothing = _FindsWidgetMatcher(null, 0);

/// Asserts that the [Finder] locates at least one widget in the widget tree.
///
/// ## Example
///
/// ```dart
/// expect(tester.find.text('Save'), findsWidgets);
/// ```
///
/// See also:
///
///  * [findsNothing], when you want the finder to not find anything.
///  * [findsOneWidget], when you want the finder to find exactly one widget.
///  * [findsNWidgets], when you want the finder to find a specific number of
/// widgets.
///
const Matcher findsWidgets = _FindsWidgetMatcher(1, null);

/// Asserts that the [Finder] locates at exactly one widget in the widget tree.
///
/// ## Example
///
/// ```dart
/// expect(tester.find.text('Save'), findsOneWidget);
/// ```
///
/// See also:
///
///  * [findsNothing], when you want the finder to not find anything.
///  * [findsWidgets], when you want the finder to find one or more widgets.
///  * [findsNWidgets], when you want the finder to find a specific number of
/// widgets.
///
const Matcher findsOneWidget = _FindsWidgetMatcher(1, 1);

/// Asserts that the [Finder] locates the specified number of widgets in the
/// widget tree.
///
/// ## Example
///
/// ```dart
/// expect(tester.find.text('Save'), findsNWidgets(2));
/// ```
///
/// See also:
///
///  * [findsNothing], when you want the finder to not find anything.
///  * [findsWidgets], when you want the finder to find one or more widgets.
///  * [findsOneWidget], when you want the finder to find exactly one widget.
///
Matcher findsNWidgets(int n) => _FindsWidgetMatcher(n, n);

/// Asserts that an object's toString() is a plausible one-line description.
///
/// Specifically, this matcher checks that the string does not contains newline
/// characters, and does not have leading or trailing whitespace, is not
/// empty, and does not contain the default `Instance of ...` string.
///
const Matcher hasOneLineDescription = _HasOneLineDescription();

/// Asserts that an object's toStringDeep() is a plausible multiline
/// description.
///
/// Specifically, this matcher checks that an object's
/// `toStringDeep(prefixLineOne, prefixOtherLines)`:
///
///  * Does not have leading or trailing whitespace.
///  * Does not contain the default `Instance of ...` string.
///  * The last line has characters other than tree connector characters and
///    whitespace. For example: the line ` │ ║ ╎` has only tree connector
///    characters and whitespace.
///  * Does not contain lines with trailing white space.
///  * Has multiple lines.
///  * The first line starts with `prefixLineOne`
///  * All subsequent lines start with `prefixOtherLines`.
///
const Matcher hasAGoodToStringDeep = _HasGoodToStringDeep();

/// Asserts that textual contents of a dom's node are equals to [contents].
///
Matcher hasContents(String contents) => _DomNodeHasContents(contents);

/// A matcher for [AssertionError].
///
/// This is equivalent to `isInstanceOf<AssertionError>()`.
///
final TypeMatcher<AssertionError> isAssertionError = isA<AssertionError>();

/// A matcher that compares the type of the actual value to the type argument T.
///
/// This is identical to [isA] and is included for backwards compatibility.
///
TypeMatcher<T> isInstanceOf<T>() => isA<T>();

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
    final Iterator<WidgetObject> iterator = finder.evaluate().iterator;

    if (min != null) {
      while (count < min! && iterator.moveNext()) {
        count += 1;
      }

      if (count < min!) return false;
    }

    if (max != null) {
      while (count <= max! && iterator.moveNext()) {
        count += 1;
      }

      if (count > max!) return false;
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
      'between $min and $max matching nodes in the widget tree (inclusive)',
    );
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
        return mismatchDescription.add(
          'means none were found but one was expected',
        );
      }

      return mismatchDescription.add(
        'means none were found but some were expected',
      );
    }

    if (max == 0) {
      if (count == 1) {
        return mismatchDescription.add(
          'means one was found but none were expected',
        );
      }

      return mismatchDescription.add(
        'means some were found but none were expected',
      );
    }

    if (min != null && count < min!) {
      return mismatchDescription.add('is not enough');
    }

    assert(max != null && count > min!);
    return mismatchDescription.add('is too many');
  }
}

class _HasOneLineDescription extends Matcher {
  const _HasOneLineDescription();

  @override
  bool matches(dynamic object, Map<dynamic, dynamic> matchState) {
    final String description = object.toString();
    return description.isNotEmpty &&
        !description.contains('\n') &&
        !description.contains('Instance of ') &&
        description.trim() == description;
  }

  @override
  Description describe(Description description) =>
      description.add('one line description');
}

/// Returns true if [c] represents a whitespace code unit.
///
bool _isWhitespace(int c) => (c <= 0x000D && c >= 0x0009) || c == 0x0020;

/// Returns true if [c] represents a vertical line Unicode line art code unit.
///
bool _isVerticalLine(int c) {
  return c == 0x2502 || c == 0x2503 || c == 0x2551 || c == 0x254e;
}

/// Returns whether a [line] is all vertical tree connector characters.
///
/// Example vertical tree connector characters: `│ ║ ╎`.
/// The last line of a text tree contains only vertical tree connector
/// characters indicates a poorly formatted tree.
///
bool _isAllTreeConnectorCharacters(String line) {
  for (int i = 0; i < line.length; ++i) {
    final int c = line.codeUnitAt(i);
    if (!_isWhitespace(c) && !_isVerticalLine(c)) return false;
  }
  return true;
}

class _HasGoodToStringDeep extends Matcher {
  const _HasGoodToStringDeep();

  static final Object _toStringDeepErrorDescriptionKey = Object();

  @override
  bool matches(dynamic object, Map<dynamic, dynamic> matchState) {
    final List<String> issues = <String>[];
    String description =
        object.toStringDeep() as String; // ignore: avoid_dynamic_calls
    if (description.endsWith('\n')) {
      // Trim off trailing \n as the remaining calculations assume
      // the description does not end with a trailing \n.
      description = description.substring(0, description.length - 1);
    } else {
      issues.add('Not terminated with a line break.');
    }

    if (description.trim() != description) {
      issues.add('Has trailing whitespace.');
    }

    final List<String> lines = description.split('\n');
    if (lines.length < 2) issues.add('Does not have multiple lines.');

    if (description.contains('Instance of ')) {
      issues.add('Contains text "Instance of ".');
    }

    for (int i = 0; i < lines.length; ++i) {
      final String line = lines[i];
      if (line.isEmpty) issues.add('Line ${i + 1} is empty.');

      if (line.trimRight() != line) {
        issues.add('Line ${i + 1} has trailing whitespace.');
      }
    }

    if (_isAllTreeConnectorCharacters(lines.last)) {
      issues.add('Last line is all tree connector characters.');
    }

    // If a toStringDeep method doesn't properly handle nested values that
    // contain line breaks it can fail to add the required prefixes to all
    // lined when toStringDeep is called specifying prefixes.
    const String prefixLineOne = 'PREFIX_LINE_ONE____';
    const String prefixOtherLines = 'PREFIX_OTHER_LINES_';
    final List<String> prefixIssues = <String>[];
    String descriptionWithPrefixes = object.toStringDeep(
      prefixLineOne: prefixLineOne,
      prefixOtherLines: prefixOtherLines,
    ) as String; // ignore: avoid_dynamic_calls
    if (descriptionWithPrefixes.endsWith('\n')) {
      // Trim off trailing \n as the remaining calculations assume
      // the description does not end with a trailing \n.
      descriptionWithPrefixes = descriptionWithPrefixes.substring(
        0,
        descriptionWithPrefixes.length - 1,
      );
    }
    final List<String> linesWithPrefixes = descriptionWithPrefixes.split('\n');
    if (!linesWithPrefixes.first.startsWith(prefixLineOne)) {
      prefixIssues.add('First line does not contain expected prefix.');
    }

    for (int i = 1; i < linesWithPrefixes.length; ++i) {
      if (!linesWithPrefixes[i].startsWith(prefixOtherLines)) {
        prefixIssues.add('Line ${i + 1} does not contain the expected prefix.');
      }
    }

    final StringBuffer errorDescription = StringBuffer();
    if (issues.isNotEmpty) {
      errorDescription.writeln('Bad toStringDeep():');
      errorDescription.writeln(description);
      errorDescription.writeAll(issues, '\n');
    }

    if (prefixIssues.isNotEmpty) {
      errorDescription.writeln(
        'Bad toStringDeep(prefixLineOne: "$prefixLineOne", prefixOtherLines: '
        '"$prefixOtherLines"):',
      );
      errorDescription.writeln(descriptionWithPrefixes);
      errorDescription.writeAll(prefixIssues, '\n');
    }

    if (errorDescription.isNotEmpty) {
      matchState[_toStringDeepErrorDescriptionKey] =
          errorDescription.toString();
      return false;
    }
    return true;
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map<dynamic, dynamic> matchState,
    bool verbose,
  ) {
    if (matchState.containsKey(_toStringDeepErrorDescriptionKey)) {
      return mismatchDescription
          .add(matchState[_toStringDeepErrorDescriptionKey] as String);
    }
    return mismatchDescription;
  }

  @override
  Description describe(Description description) {
    return description.add('multi line description');
  }
}

class _DomNodeHasContents extends Matcher {
  final String expected;

  const _DomNodeHasContents(this.expected);

  @override
  matches(Object? item, void _) => _domNodeText(item) == expected;

  @override
  describe(description) {
    description.add(expected);

    return description;
  }

  @override
  describeMismatch(
    item,
    mismatchDescription,
    void _,
    void __,
  ) {
    mismatchDescription.add("Serialized contents: '${_domNodeText(item)}'");

    return mismatchDescription;
  }
}

String? _domNodeText(Object? n) {
  if (n is Iterable) {
    return n.map(_domNodeText).join('|');
  } else if (n is Node) {
    if (n is ContentElement) {
      return _domNodeText(n.getDistributedNodes());
    }

    if (n is Element && n.shadowRoot != null) {
      return _domNodeText(n.shadowRoot!.nodes);
    }

    if (n.nodes.isNotEmpty) {
      return _domNodeText(n.nodes);
    }

    return n.text;
  } else {
    return '$n';
  }
}

/// Testing library for Rad, built on top of `package:test`.
///
library rad_test;

/*
|--------------------------------------------------------------------------
| types
|--------------------------------------------------------------------------
*/

export 'src/common/types.dart' show WidgetPredicate;
export 'src/common/types.dart' show WidgetTesterCallback;
export 'src/common/types.dart' show RenderElementPredicate;

/*
|--------------------------------------------------------------------------
| testers
|--------------------------------------------------------------------------
*/

export 'src/modules/testers.dart' show testWidgets;
export 'src/modules/widget_tester.dart' show WidgetTester;

/*
|--------------------------------------------------------------------------
| utilities
|--------------------------------------------------------------------------
*/

export 'src/utilities/test_stack.dart' show TestStack;
export 'src/utilities/test_window.dart' show TestWindow;

/*
|--------------------------------------------------------------------------
| matchers
|--------------------------------------------------------------------------
*/

export 'src/modules/matchers.dart' show findsNothing;
export 'src/modules/matchers.dart' show findsWidgets;
export 'src/modules/matchers.dart' show findsOneWidget;
export 'src/modules/matchers.dart' show findsNWidgets;

export 'src/modules/matchers.dart' show domNodeHasFocus;
export 'src/modules/matchers.dart' show domNodeHasNotFocus;
export 'src/modules/matchers.dart' show domNodeHasValue;
export 'src/modules/matchers.dart' show domNodeHasContents;

export 'src/modules/matchers.dart' show hasOneLineDescription;
export 'src/modules/matchers.dart' show hasAGoodToStringDeep;

export 'src/modules/matchers.dart' show isWatchfulMounted, isWatchfulNotMounted;
export 'src/modules/matchers.dart'
    show areWatchfulMounted, areWatchfulNotMounted;

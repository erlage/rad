// ignore_for_file: camel_case_types

import '../test_imports.dart';

class RT_InheritedWidget extends InheritedWidget {
  final Callback? eventUpdateShouldNotify;

  final void Function({
    required RT_InheritedWidget calledOnWidget,
    required RT_InheritedWidget calledWithWidget,
  })? hookUpdateShouldNotify;

  final bool Function()? overrideUpdateShouldNotify;

  final String hash;

  RT_InheritedWidget({
    Key? key,
    this.eventUpdateShouldNotify,
    this.hookUpdateShouldNotify,
    this.overrideUpdateShouldNotify,
    required Widget child,
    String? customHash,
  })  : hash = customHash ?? 'none',
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant RT_InheritedWidget oldWidget) {
    if (null != eventUpdateShouldNotify) {
      eventUpdateShouldNotify!();
    }

    if (null != hookUpdateShouldNotify) {
      hookUpdateShouldNotify!(
        calledOnWidget: this,
        calledWithWidget: oldWidget,
      );
    }

    if (null != overrideUpdateShouldNotify) {
      return overrideUpdateShouldNotify!();
    }

    return true;
  }
}

// ignore_for_file: camel_case_types

import '../test_imports.dart';

class RT_TestPopStateListener {
  var events = <PopStateEvent>[];

  void listener(PopStateEvent event) {
    print('event');
    events.add(event);
  }
}

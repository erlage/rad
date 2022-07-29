// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_relative_lib_imports

import '../../test_imports.dart';

void main() {
  Event? nativeEvent;
  EmittedEvent? event;

  setUp(() {
    nativeEvent = Event('click');
    event = EmittedEvent.fromNativeEvent(nativeEvent!);
  });

  test('should return native event', () {
    expect(event?.nativeEvent, equals(nativeEvent));
  });

  test("should forward getter 'type'", () {
    expect(event?.type, equals(nativeEvent?.type));
  });

  test("should forward getter 'bubbles'", () {
    expect(event?.bubbles, equals(nativeEvent?.bubbles));
  });

  test("should forward getter 'composed'", () {
    expect(event?.composed, equals(nativeEvent?.composed));
  });

  test("should forward getter 'timeStamp'", () {
    expect(event?.timeStamp, equals(nativeEvent?.timeStamp));
  });

  test("should forward getter 'eventPhase'", () {
    expect(event?.eventPhase, equals(nativeEvent?.eventPhase));
  });

  test("should forward getter 'isTrusted'", () {
    expect(event?.isTrusted, equals(nativeEvent?.isTrusted));
  });

  test("should forward getter 'cancelable'", () {
    expect(event?.cancelable, equals(nativeEvent?.cancelable));
  });

  test("should forward getter 'defaultPrevented'", () {
    expect(event?.defaultPrevented, equals(nativeEvent?.defaultPrevented));
  });

  test("should forward getter 'path'", () {
    expect(event?.path, equals(nativeEvent?.path));
  });

  test("should forward getter 'target'", () {
    expect(event?.target, equals(nativeEvent?.target));
  });

  test("should forward getter 'currentTarget'", () {
    expect(event?.currentTarget, equals(nativeEvent?.currentTarget));
  });
}

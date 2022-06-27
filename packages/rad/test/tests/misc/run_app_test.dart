// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| start app tests
|--------------------------------------------------------------------------
*/

void main() {
  group('start app tests :', () {
    setUp(() {
      // we are testing real runApp and it throws if called twice with same
      // targetId(as expected)
      ServicesRegistry.instance.unRegisterServices(
        RT_TestBed.rootRenderElement,
      );
    });

    test('should run app', () async {
      runApp(
        app: Text('hello world'),
        targetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration.zero, () {
        expect(RT_TestBed.rootDomNode, RT_hasContents('hello world'));
      });
    });

    test('should throw if target not found', () async {
      expect(
        () => runApp(
          app: Text('hello world'),
          targetId: 'some-non-existent-target',
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Unable to locate target'),
          ),
        ),
      );
    });

    test('should run before mount task before actual mount', () async {
      runApp(
          app: Text('hello world'),
          targetId: RT_TestBed.rootTargetId,
          beforeMount: () {
            expect(RT_TestBed.rootDomNode, RT_hasContents(''));
          });

      await Future.delayed(Duration.zero);
    });
  });
}

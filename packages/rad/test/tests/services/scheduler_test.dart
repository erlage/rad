// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Scheduler tests
|--------------------------------------------------------------------------
*/

void main() {
  group('task tests', () {
    test('should send tasks in order:', () async {
      var testStack = RT_TestStack();

      var schedulerService = SchedulerService(
        RT_TestBed.rootRenderElement,
        SchedulerOptions.defaultMode,
      )..startService();

      schedulerService.addTaskListener('test', (task) {
        testStack.push(task.taskType.name);
        schedulerService.addEvent(SendNextTaskEvent('test'));
      });

      schedulerService.addTask(
        WidgetsBuildTask(
          widgets: [],
          parentRenderElement: RT_TestBed.rootRenderElement,
        ),
      );

      schedulerService.addTask(
        WidgetsUpdateTask(
          widgets: [],
          updateType: UpdateType.undefined,
          parentRenderElement: RT_TestBed.rootRenderElement,
        ),
      );

      schedulerService.addTask(
        WidgetsManageTask(
          parentRenderElement: RT_TestBed.rootRenderElement,
          widgetActionCallback: (renderElement) => [],
        ),
      );

      schedulerService.addTask(
        WidgetsUpdateDependentTask(
          dependentRenderElement: RT_TestBed.rootRenderElement,
        ),
      );

      schedulerService.addTask(StimulateListenerTask());

      await Future.delayed(Duration.zero, () {
        var expected = [
          SchedulerTaskType.build.name,
          SchedulerTaskType.update.name,
          SchedulerTaskType.manage.name,
          SchedulerTaskType.updateDependent.name,
        ].toString();

        var actual = testStack.entries
          ..removeWhere(
            (e) => e == SchedulerTaskType.stimulateListener.name,
          );

        expect(actual.toString(), equals(expected));
      });
    });

    test(
      'should send tasks only when requested:',
      () async {
        var testStack = RT_TestStack();
        var schedulerService = SchedulerService(
          RT_TestBed.rootRenderElement,
          SchedulerOptions.defaultMode,
        )..startService();

        schedulerService.addTaskListener('test', (task) {
          testStack.push(task.taskType.name);
        });

        schedulerService.addTask(
          WidgetsBuildTask(
            widgets: [],
            parentRenderElement: RT_TestBed.rootRenderElement,
          ),
        );

        schedulerService.addTask(
          WidgetsUpdateTask(
            widgets: [],
            updateType: UpdateType.undefined,
            parentRenderElement: RT_TestBed.rootRenderElement,
          ),
        );

        schedulerService.addTask(StimulateListenerTask());

        await Future.delayed(Duration.zero, () {
          var expected = [].toString();

          // StimulateListenerTask task is a exception here,
          // because we want listeners to know that there are new tasks which
          // scheduler can send if they want.

          var actual = testStack.entries
            ..removeWhere(
              (e) => e == SchedulerTaskType.stimulateListener.name,
            );

          expect(actual.toString(), equals(expected));
        });
      },
      skip: 'impl has been changed, todo: remove this test',
    );
  });
}

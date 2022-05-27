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
        RT_TestBed.rootContext,
        SchedulerOptions.defaultMode,
      )..startService();

      schedulerService.addTaskListener('test', (task) {
        testStack.push(task.taskType.name);
        schedulerService.addEvent(SendNextTaskEvent('test'));
      });

      schedulerService.addTask(
        WidgetsBuildTask(
          widgets: [],
          parentContext: RT_TestBed.rootContext,
        ),
      );

      schedulerService.addTask(
        WidgetsUpdateTask(
          widgets: [],
          updateType: UpdateType.undefined,
          parentContext: RT_TestBed.rootContext,
        ),
      );

      schedulerService.addTask(
        WidgetsManageTask(
          parentContext: RT_TestBed.rootContext,
          widgetActionCallback: (widgetObject) => [],
        ),
      );

      schedulerService.addTask(
        WidgetsUpdateDependentTask(widgetContext: RT_TestBed.rootContext),
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
          RT_TestBed.rootContext,
          SchedulerOptions.defaultMode,
        )..startService();

        schedulerService.addTaskListener('test', (task) {
          testStack.push(task.taskType.name);
        });

        schedulerService.addTask(
          WidgetsBuildTask(
            widgets: [],
            parentContext: RT_TestBed.rootContext,
          ),
        );

        schedulerService.addTask(
          WidgetsUpdateTask(
            widgets: [],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
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

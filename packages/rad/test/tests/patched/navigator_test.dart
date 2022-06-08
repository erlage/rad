// ignore_for_file: camel_case_types

// Issues: #4

import '../../test_imports.dart';

void main() {
  group('rendering duplicate widgets #4', () {
    test('should render correct markup', () async {
      runApp(
        app: _NavigatorTest4(),
        targetId: RT_TestBed.rootKey.value,
      );

      await Future.delayed(Duration.zero, () {
        expect(
          RT_TestBed.rootElement,
          RT_hasContents('|some text on route||more text'),
        );
      });
    });
  });
}

class _NavigatorTest4 extends StatefulWidget {
  const _NavigatorTest4({Key? key}) : super(key: key);

  @override
  _NavigatorTestState createState() => _NavigatorTestState();
}

class _NavigatorTestState extends State<_NavigatorTest4> {
  @override
  build(context) {
    return Division(
      children: [
        navigatorContent(),
        Text('|more text'),
      ],
    );
  }

  Widget navigatorContent() {
    return Navigator(
      onInit: (state) => setState(() {}),
      onRouteChange: (name) => setState(() {}),
      routes: [
        Route(name: 'some', page: Text('|some text on route')),
      ],
    );
  }
}
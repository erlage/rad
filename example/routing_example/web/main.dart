import 'package:rad/rad.dart';
import 'package:rad/widgets_html.dart';

import 'settings_page.dart';

void main() {
  startApp(
    app: RadApp(child: RootPage()),
    targetId: 'output',
    debugOptions: DebugOptions.developmentMode,
  );
}

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String _activeRoute = "";
  NavigatorState? _navigatorState;

  @override
  build(context) {
    return Division(
      style: "display: flex; flex-direction: column;",
      children: [
        _rootPageTopNav(),
        _rootPageNavigator(),
      ],
    );
  }

  Widget _rootPageNavigator() {
    return Navigator(
      onInit: _onNavigatorInit,
      onRouteChange: _onNavigatorRouteChange,
      routes: const [
        Route(name: 'home', page: Text("Home page")),
        Route(name: 'posts', page: Text("Posts page")),
        Route(name: 'settings', page: SettingsPage()),
      ],
    );
  }

  Widget _rootPageTopNav() {
    return Division(
      classAttribute: "header",
      style: "width:100%; height:50px;",
      child: Division(
        style: "display: flex; flex-direction: row;"
            "gap: 20px; justify-content: center;",
        children: [
          _headerItem(text: "Home", routeName: "home"),
          _headerItem(text: "Posts", routeName: "posts"),
          _headerItem(text: "Settings", routeName: "settings"),
        ],
      ),
    );
  }

  Widget _headerItem({required String routeName, required String text}) {
    return GestureDetector(
      onTap: () => _navigatorState?.open(name: routeName),
      child: Division(
        style: "width: 100px; padding: 15px;",
        classAttribute: _activeRoute == routeName ? "active" : "",
        child: Division(
          style: "margin: 0 auto;",
          child: Text(text),
        ),
      ),
    );
  }

  void _onNavigatorInit(NavigatorState state) {
    _navigatorState = state;
  }

  void _onNavigatorRouteChange(String name) {
    setState(() {
      _activeRoute = name;
    });
  }
}

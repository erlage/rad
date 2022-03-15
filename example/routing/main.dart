import 'package:rad/rad.dart';

import 'settings_page.dart';

void main() {
  App(
    targetKey: "output",
    child: RootPage(),
    debugOptions: DebugOptions(
      widgetLogs: true,
      developmentMode: true,
    ),
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
        Division(
          children: [
            _rootPageNavigator(),
          ],
        ),
      ],
    );
  }

  Widget _rootPageNavigator() {
    return Navigator(
      onInit: _onNavigatorInit,
      onRouteChange: _onNavigatorRouteChange,
      routes: [
        Route(name: 'home', page: HomePage()),
        Route(name: 'posts', page: PostsPage()),
        Route(name: 'settings', page: SettingsPage()),
      ],
    );
  }

  Widget _rootPageTopNav() {
    return Division(
      classAttribute: "header",
      style: "width:100%; height:50px;",
      children: [
        Division(
          style:
              "display: flex; flex-direction: row; gap:20px; justify-content: center;",
          children: [
            _headerItem(text: "Home", routeName: "home"),
            _headerItem(text: "Posts", routeName: "posts"),
            _headerItem(text: "Settings", routeName: "settings"),
          ],
        ),
      ],
    );
  }

  Widget _headerItem({required String routeName, required String text}) {
    return GestureDetector(
      onTap: () => _navigatorState?.open(name: routeName),
      child: Division(
        style: "width: 100px;padding:15px",
        classAttribute: _activeRoute == routeName ? "active" : "",
        children: [
          Division(
            style: "margin: 0 auto;",
            children: [Text(text)],
          ),
        ],
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

class HomePage extends StatelessWidget {
  @override
  build(context) {
    return Text("Home page");
  }
}

class PostsPage extends StatelessWidget {
  @override
  build(context) {
    return Text("Posts page");
  }
}

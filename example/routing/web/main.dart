import 'package:rad/rad.dart';

import 'settings_page.dart';

void main() {
  RadApp(
    targetId: "output",
    child: RootPage(),
  );
}

class RootPage extends StatefulWidget {
  String _activeRoute = "";
  NavigatorState? _navigatorState;

  @override
  build(context) {
    return Column(
      children: [
        _rootPageTopNav(),
        Expanded(child: _rootPageNavigator()),
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
    return SizedBox(
      size: "100% 50px",
      styles: "header",
      child: Row(
        gap: 20,
        mainAxisAlignment: MainAxisAlignment.center,
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
      child: SizedBox(
        size: "100px 100%",
        styles: _activeRoute == routeName ? "active" : "",
        child: Center(
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

class HomePage extends StatelessWidget {
  @override
  build(context) {
    return Center(
      child: Text("Home page"),
    );
  }
}

class PostsPage extends StatelessWidget {
  @override
  build(context) {
    return Center(
      child: Text("Posts page"),
    );
  }
}

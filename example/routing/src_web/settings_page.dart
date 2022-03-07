import 'package:rad/rad.dart';

class SettingsPage extends StatefulWidget {
  String _activeRoute = "";
  NavigatorState? _navigatorState;

  @override
  build(context) {
    return Row(
      children: [
        _settingsPageVeritcalNav(),
        Expanded(child: _settingsPageNavigator()),
      ],
    );
  }

  Widget _settingsPageNavigator() {
    return Navigator(
      onInit: _onNavigatorInit,
      onRouteChange: _onNavigatorRouteChange,
      routes: [
        Route(name: 'account', page: Page("Account Settings")),
        Route(name: 'photos', page: Page("Photos Settings")),
        Route(name: 'videos', page: Page("Videos Settings")),
        Route(name: 'personal', page: Page("Personal Settings")),
      ],
    );
  }

  Widget _settingsPageVeritcalNav() {
    return SizedBox(
      styles: "vertical-header",
      size: "250px 100%",
      child: Column(
        gap: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(size: "100% 20px"),
          _headerItem(text: "Account settings", routeName: "account"),
          _headerItem(text: "Photos settings", routeName: "photos"),
          _headerItem(text: "Videos settings", routeName: "videos"),
          _headerItem(text: "Personal information", routeName: "personal"),
        ],
      ),
    );
  }

  Widget _headerItem({required String routeName, required String text}) {
    return GestureDetector(
      onTap: () {
        _navigatorState?.open(name: routeName);
      },
      child: SizedBox(
        size: "100%",
        styles: _activeRoute == routeName ? "active" : "",
        child: Container(
          padding: "15px",
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

class Page extends StatelessWidget {
  final String title;

  Page(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}

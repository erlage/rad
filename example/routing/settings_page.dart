import 'package:rad/rad.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _activeRoute = "";
  NavigatorState? _navigatorState;

  @override
  build(context) {
    return Division(
      style:
          "display: flex; flex-direction: row; gap:20px; justify-content: center;",
      children: [
        _settingsPageVeritcalNav(),
        Division(
          style: "flex: 1",
          children: [_settingsPageNavigator()],
        ),
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
    return Division(
      style: "width:250px; height: 100%;",
      classAttribute: "vertical-header",
      children: [
        Division(
          style:
              "display: flex; flex-direction: column; justify-content: flex-start; gap: 10px;",
          children: [
            Division(style: "width: 100%; height: 20px;"),
            _headerItem(text: "Account settings", routeName: "account"),
            _headerItem(text: "Photos settings", routeName: "photos"),
            _headerItem(text: "Videos settings", routeName: "videos"),
            _headerItem(text: "Personal information", routeName: "personal"),
          ],
        ),
      ],
    );
  }

  Widget _headerItem({required String routeName, required String text}) {
    return GestureDetector(
      onTap: () {
        _navigatorState?.open(name: routeName);
      },
      child: Division(
        style: "widht: 100%",
        classAttribute: _activeRoute == routeName ? "active" : "",
        children: [
          Division(
            style: "padding: 15px;",
            innerText: text,
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

class Page extends StatelessWidget {
  final String title;

  Page(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

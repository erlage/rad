import 'package:rad/rad.dart';
import 'package:rad/widgets_html.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _activeRoute = '';
  NavigatorState? _navigatorState;

  @override
  build(context) {
    return Division(
      classAttribute: 'horizontal-header-content',
      children: [
        _settingsPageVeritcalNav(),
        Division(
          style: 'flex: 1',
          child: _settingsPageNavigator(),
        ),
      ],
    );
  }

  Widget _settingsPageNavigator() {
    return Navigator(
      onInit: _onNavigatorInit,
      onRouteChange: _onNavigatorRouteChange,
      routes: const [
        Route(name: 'account', page: Page('Account Settings')),
        Route(name: 'photos', page: Page('Photos Settings')),
        Route(name: 'videos', page: Page('Videos Settings')),
        Route(name: 'personal', page: Page('Personal Settings')),
      ],
    );
  }

  Widget _settingsPageVeritcalNav() {
    return Division(
      classAttribute: 'vertical-header',
      child: Division(
        classAttribute: 'vertical-header-content',
        children: [
          const Spacer(),
          _headerItem(text: 'Account settings', routeName: 'account'),
          _headerItem(text: 'Photos settings', routeName: 'photos'),
          _headerItem(text: 'Videos settings', routeName: 'videos'),
          _headerItem(text: 'Personal information', routeName: 'personal'),
        ],
      ),
    );
  }

  Widget _headerItem({required String routeName, required String text}) {
    return GestureDetector(
      onTap: () {
        _navigatorState?.open(name: routeName);
      },
      child: Division(
        style: 'widht: 100%;',
        classAttribute: _activeRoute == routeName ? 'active' : '',
        children: [
          Division(
            style: 'padding: 15px;',
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

  const Page(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

class Spacer extends Division {
  const Spacer() : super(style: 'width: 100%; height: 20px;');
}

A simple click testing demo using Rad:
```dart
import 'package:rad/rad.dart';

void main() {
  RadApp(
    targetKey: "output",
    child: ClickToggle(),
  );
}

class ClickToggle extends StatefulWidget {

  @override
  _ClickToggleState createState() => _ClickToggleState();
}

class _ClickToggleState extends State<ClickToggle> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Text(isClicked ? "on! click to turn off." : "click to turn on."),
    );
  }

  _handleTap() {
    setState(() {
      isClicked = !isClicked;
    });
  }
}
```

For installing Rad please refer to [package homepage](https://pub.dev/packages/rad)
A simple click testing demo using Rad:
```dart
import 'package:rad/rad.dart';

void main() {
  RadApp(
    targetId: "output",
    child: ClickTest(),
  );
}

class ClickTest extends StatefulWidget {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Text(isClicked ? "clicked!" : "click me"),
    );
  }

  handleTap() {
    setState(() {
      isClicked = !isClicked;
    });
  }
}
```

For installing Rad please refer to [package homepage](https://pub.dev/packages/rad)
import 'package:trad/trad.dart';
import 'package:trad/widgets.dart';

void main() {
  TradApp(
    targetId: "output",
    child: ClickTest(),
  );
}

class ClickTest extends StatefulWidget {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (event) => handleTap(),
      child: Text(isClicked ? "clicked!" : "click me"),
    );
  }

  handleTap() {
    setState(() {
      isClicked = !isClicked;
    });
  }
}

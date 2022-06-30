import 'dart:async';
import 'package:rad/rad.dart';
import 'package:rad/widgets_html.dart';

void main() {
  runApp(
    app: const Counter(interval: Duration(seconds: 1)),
    appTargetId: 'app-a',
  );
  runApp(
    app: const Counter(interval: Duration(seconds: 2)),
    appTargetId: 'app-b',
  );
}

class Counter extends StatefulWidget {
  final Duration interval;

  const Counter({Key? key, required this.interval}) : super(key: key);

  @override
  State<Counter> createState() => CounterState();
}

class CounterState extends State<Counter> {
  int number = 0;

  @override
  void initState() {
    Timer.periodic(widget.interval, (timer) {
      setState(() {
        number = timer.tick;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Division(
      children: [
        const Strong(child: Text('Current tick: ')),
        Division(child: Text('$number')),
      ],
    );
  }
}

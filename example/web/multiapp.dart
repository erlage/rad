import 'dart:async';
import 'package:rad/rad.dart';

void main() {
  startApp(Counter(interval: Duration(seconds: 1)), 'app-a');
  startApp(Counter(interval: Duration(seconds: 2)), 'app-b');
}

class Counter extends StatefulWidget {
  final Duration interval;

  const Counter({String? key, required this.interval}) : super(key: key);

  @override
  State<Counter> createState() => CounterState();
}

class CounterState extends State<Counter> {
  int number = 0;

  void initState() {
    Timer.periodic(widget.interval, (timer) {
      setState(() {
        number = timer.tick;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Division(children: [
      Strong(child: Text('Current tick: ')),
      Span(child: Text('$number')),
    ]);
  }
}

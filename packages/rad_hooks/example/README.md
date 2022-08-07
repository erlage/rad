### Sample:

A basic example with useState hook:

```dart
Widget widgetFunction() => HookScope(() {
  // create a stateful value
  var state = useState(0);

  return Span(
    child: Text('You clicked me ${state.value} time!'),
    onClick: (_) => state.value++, // will cause a re-render
  ); 
});

runApp(app: widgetFunction(), ...);
```

### Creating custom hooks

Rad supports a easy yet powerful Hooks API that you can use to create your own hooks. There are number of hooks that we provide which you can use by importing the package [rad_hooks](https://pub.dev/packages/rad_hooks). If you want to create your own hooks, feel free check out implementations residing inside package.

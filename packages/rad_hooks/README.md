## Rad Hooks

[![Rad(hooks-pkg)](https://github.com/erlage/rad/actions/workflows/rad_hooks_pkg.yml/badge.svg)](https://github.com/erlage/rad/actions/workflows/rad_hooks_pkg.yml)

A set of commonly used hooks for using in your Rad applications.

### Basic Usage

```dart
Widget someReusableWidget() => HookScope(() {

  // create a state variable

  var state = useState(1);

  return Span(
    innerText: 'You clicked me ${state.value} times!',
    onClick: (e) => state.value++, // <- update state(causes re-render)
  );
});

void main() {
  runApp( 
    app: someReusableWidget(),
    appTargetId: 'output',
  );
}
```

## Available Hooks

[useRef](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useRef.html)
, [useState](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useState.html)
, [useMemo](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useMemo.html)
, [useCallback](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useCallback.html)
, [useEffect](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useEffect.html)
, [useLayoutEffect](https://pub.dev/documentation/rad_hooks/latest/rad_hooks/useLayoutEffect.html)

For complete reference of available hooks, please refer to [index page](https://github.com/erlage/rad/blob/main/README.md).

## Creating custom hooks

This package also serves as an example that show cases flexibility and power of hooks APIs in Rad. If you feel like missing a hook, you can just create it and hook it in your application. We recommend you to look into implementation of hooks included in this package for getting an idea on how to create your own hooks which then can be used directly in your Rad applications.

## Contributing

For reporting bugs/queries, feel free to open issue. Read [contributing guide](https://github.com/erlage/rad/blob/main/CONTRIBUTING.md) for more.

## Rad HTML Widgets(Visual-JSX Ready)

[![Rad(rad-html-vscode-pkg)](https://github.com/erlage/rad/actions/workflows/rad_html_vscode_pkg.yml/badge.svg)](https://github.com/erlage/rad/actions/workflows/rad_html_vscode_pkg.yml)

This package provides a set of HTML widgets that integrate seamlessly with the Visual-JSX feature of the [Rad framework's VSCode extension](https://marketplace.visualstudio.com/items?itemName=erlage.rad). The widgets are designed to be simple, easy to use, and make it possible to write HTML in Dart with minimal effort, while taking advantage of the powerful Visual-JSX syntax helpers.

## Differences from Rad's HTML widgets

- No `innerText` argument: Use Text widget.

- No Named `child`/`children` argument: Child widgets can be passed as a list anywhere, but it is preferred to pass them as the last argument.

- No Descriptive Aliases: Unlike the official HTML widgets, this package does not provide full name aliases for the widgets. Instead, this package provides only short syntax that matches the HTML tags.

In nutshell,

```dart
// instead of
//    div()
//    Division()
//    div(child: null)
//    div(child: [])
//    div(children: null)
//    div(children: [])

// we've only this
div([]),
```

## Contributing

For reporting bugs/queries, feel free to open issue. Read [contributing guide](https://github.com/erlage/rad/blob/main/CONTRIBUTING.md) for more.

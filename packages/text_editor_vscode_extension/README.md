# Rad - VSCode Extension

This extension provides an enhanced development experience for developers working with the Rad Framework. With its powerful features, this extension makes it easier for developers to write and manage code, saving time and increasing productivity.

## Features

- Visual JSX: Dart to JSX Visualizer
- HTML2Rad: HTML to Rad Transpiler

## Installation

- Open Visual Studio Code
- Click on the Extensions button on the left side of the window
- Search for "Rad framework"
- Click the Install button to install the extension
- Click the Reload button to reload Visual Studio Code after the extension has been installed

## Visual-JSX

Visual-JSX is a feature designed to make managing HTML code written in Dart easier. It transforms HTML widgets into a visually appealing, JSX-like syntax, making it easier to understand and maintain your HTML widgets.

![Visual-JSX Preview](https://photogram.erlage.com/tmp/rad_vscode_peek1.gif)

**Note**: Visual-JSX does not parse or visualize original HTML widgets(that are included in Rad's framework package). By default, Visual-JSX only works with HTML widgets from the [rad_html_vscode](https://pub.dev/packages/rad_html_vscode) package, so it is recommended to use it for the best experience. If you wish to visualize original HTML widgets, you can turn on the experimental parsing feature by setting `rad.jsxEnableExperimentParsingOriginalSyntax` to true in your `settings.json` file.

### Toggling JSX

Toggle commands makes it easy to turn the Visual-JSX feature on or off as you work, allowing you to switch between the regular and Visual-JSX views as needed. Whether you prefer to work with the Visual-JSX view or the standard HTML view, you can easily switch between them to get the best results for your needs.

1. Press `Command` + `Shift` + `P` to open the Command Palette in Visual Studio Code.

2. Type `Visual-JSX: Toggle Visualization` in the search bar and select the option from the list.

For getting better visualization:

1. Set `dart.closingLabels` to false in your `settings.json`.

2. Set `dart.lineLength` to >(100-120) in your `settings.json`.

3. Theme colors are hardcoded(for now) and works best with Atom One Light/Dark theme.

#### Pretty Mode

1. Press `Command` + `Shift` + `P` to open the Command Palette in Visual Studio Code.

2. Type `Visual-JSX: Toggle Pretty Mode` in the search bar and select the option from the list.

## HTML2Rad

This feature allows you to convert HTML markup directly into Rad's HTML widgets.

![Transpiler Preview](https://photogram.erlage.com/tmp/rad_vscode_peek2.gif)

**Note**: By default, HTML2Rad outputs syntax that matches with HTML widgets of the package [rad_html_vscode](https://pub.dev/packages/rad_html_vscode) package. If you wish to output different set of HTML widgets, such as HTML widgets from Rad's framework package, please configure `rad.html2RadOutputSyntax` in your `settings.json` file.

## Contributing

Please note that this extension is currently in its early phase and may require some improvements. Your feedback and suggestions are greatly appreciated to help us make the necessary improvements. For reporting bugs/queries, feel free to open issue. Read [contributing guide](https://github.com/erlage/rad/blob/main/CONTRIBUTING.md) for more.

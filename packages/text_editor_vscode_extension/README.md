# Rad - VSCode Extension

## Visual-JSX: The Dart to JSX Visualizer

The main and currently the only feature of the extension is Visual-JSX. Visual-JSX is a feature designed to make managing HTML code written in Dart easier. It transforms HTML widgets into a visually appealing, JSX-like syntax, making it easier to understand and maintain your HTML widgets.

## Preview

![Image Preview](https://photogram.erlage.com/tmp/rad_vscode_peek1.gif)

## Note!

Please be aware that the Visual-JSX does not parse or visualize official HTML widgets. By default, Visual-JSX only works with HTML widgets from the [rad_html_vscode](https://pub.dev/packages/rad_html_vscode) package, so it is recommended to use it for the best experience. If you wish to visualize official HTML widgets, you can turn on the experimental parsing feature by setting `rad.jsxEnableExperimentParsingOfficialSyntax` to true in your `settings.json` file.

## Installation

- Open Visual Studio Code
- Click on the Extensions button on the left side of the window
- Search for "Rad framework"
- Click the Install button to install the extension
- Click the Reload button to reload Visual Studio Code after the extension has been installed

## Toggling JSX

Toggle commands makes it easy to turn the Visual-JSX feature on or off as you work, allowing you to switch between the regular and Visual-JSX views as needed. Whether you prefer to work with the Visual-JSX view or the standard HTML view, you can easily switch between them to get the best results for your needs.

1. Press `Command` + `Shift` + `P` to open the Command Palette in Visual Studio Code.

2. Type `Visual-JSX: Toggle Visualization` in the search bar and select the option from the list.

## Pretty Mode

1. Press `Command` + `Shift` + `P` to open the Command Palette in Visual Studio Code.

2. Type `Visual-JSX: Toggle Pretty Mode` in the search bar and select the option from the list.

## Tips

For getting better visualisation:

1. Set `dart.closingLabels` to false in your `settings.json`.

2. Set `dart.lineLength` to >(100-120) in your `settings.json`.

3. Theme colors are hardcoded(for now) and works best with Atom One Light/Dark theme.

# Contributing

Please note that this extension is currently in its early phase and may require some improvements. Your feedback and suggestions are greatly appreciated to help us make the necessary improvements. For reporting bugs/queries, feel free to open issue. Read [contributing guide](https://github.com/erlage/rad/blob/main/CONTRIBUTING.md) for more.

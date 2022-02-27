# Trad

Trad is a frontend framework for Dart. It's inspired from Flutter and shares same programming paradigm. Which means, again, you'll be working with Widgets and tress. Don't worry, widgets in Trad are similar to Flutter widgets but in many ways more flexible.

Let's take a look at one of the widget from Trad: 

```dart
class HomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: const Text("click me"),
        onTap: (event) => print("working!"),
      ),
    );
  }
}
```
How about that? if you're familiar with Flutter it don't even need a explanation. 


### How it works?

- Trad doesn't render pixels to build Wigets instead it maps widgets to HTML elements(tags), and takes care of managing DOM as whole.

- Every widget has a optional `key` parameter. Which if not provided will be generated. Keys in Trad are global, and used both internally(to find objects) & in DOM(as value of id attribute of HTML element that a widget is mapped to)

## Geting started

1. Create a demo web app:
    - `dart create -t web-simple myapp`
  
    Having troubles? learn more [from official guide](https://dart.dev/tutorials/web/get-started)
    
2. Add Trad as dependency:
    - Open `pubspec.yaml` in newly created app folder and add `trad` to your dependencies:
      ```yaml
      dependencies:
        trad: 0.0.2
      ```

3. Import Trad widgets in your `main.dart`
    ```dart
    import 'package:trad/widgets.dart';
    ```

3. Create Trad app
    ```dart
    void main() {
      TradApp(
                            // 'output' is the id of div in your web/index.html
                            // framework will mount your app inside that div
                            // if you don't have a div with id 'output' in web/index.html, 
        targetId: "output", // you've to create it
                            // e.g
                            //    <body>
                            //      <div id="output"></div> 
                            //    ...
        child: GestureDetector(
          onTap: (event) {
            print("working");
          },
          child: Container(
            child: Text("click me"),
          ),
        ),
      );
    }
    ```

3. Run `webdev serve` and follow on-screen instructions

### Debugging

Trad is a zero-dependency web framework which helps you write web apps in plain Dart(no-flutter). For debugging Dart web apps, you've follow your IDE/editor docs. See [official guide here](https://dart.dev/tools#general-purpose-tools).

If you happen to be using VS code,

- Install [VS code Dart plugin](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
- Create a `launch.json` inside `.vscode` folder - [see example](https://github.com/erlage/trad/blob/main/example/vscode/launch.json)
- Start your app in debug mode - see [this](https://code.visualstudio.com/docs/editor/debugging) for more

# Styling widgets

## Using CSS

You can add CSS rules to widgets to style them. For example:
```dart
Container(
  style: "css-class another-class",
  child: const Text("text inside a styled container"),
);
```
Note that some widgets such as StatelessWidget don't have a `style` parameter.

## Sizing & Positioning

Some widgets have parameters for their "size" or "position" or both. We refers to them as Sizing & Positioning props. Positioning props includes `left`, `right`, `top` and `bottom` parameters while `width` and `height` are Sizing props.

Widgets that accept sizing props also have a optional parameter `sizingUnit`. For positioning props there's `positioningUnit`. By default, `width: 20` will be mapped to `width: 20px`. But if you want to set width to some percentage of parent you can set `sizingUnit: MeasuringUnit.percentage` which will tell framework to map `width: 20` to `width: 20%`.

## Api reference

- [Trad library](https://pub.dev/documentation/trad/latest/trad/trad-library.html)
- [Widgets library](https://pub.dev/documentation/trad/latest/widgets/widgets-library.html)

## Widgets Index

### Main

- [TradApp](https://pub.dev/documentation/trad/latest/widgets/TradApp-class.html)

### Elements

- [Text](https://pub.dev/documentation/trad/latest/widgets/Text-class.html)

### Layout

- [Container](https://pub.dev/documentation/trad/latest/widgets/Container-class.html)
- [Stack](https://pub.dev/documentation/trad/latest/widgets/Stack-class.html)
- [Align](https://pub.dev/documentation/trad/latest/widgets/Align-class.html)

### Misc

- [GestureDetector](https://pub.dev/documentation/trad/latest/widgets/GestureDetector-class.html)

### Abstract

- [StatelessWidget](https://pub.dev/documentation/trad/latest/trad/StatelessWidget-class.html)
- [StatefulWidget](https://pub.dev/documentation/trad/latest/trad/StatefulWidget-class.html)

## Contribution
Trad is a hobby project, feel free to open pull requests if you feel like missing a widget or something. Trad's core(src/core) is extremely small and straightforward. Having [basic knowledge of DOM](https://dart.dev/tutorials/web/low-level-html/connect-dart-html) & [Dart](https://dart.dev/guides/language/language-tour) is enough to implement widgets(src/widgets).

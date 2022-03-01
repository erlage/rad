# Rad

Rad is a frontend framework for Dart. It's inspired from Flutter and shares same programming paradigm. Widgets are the centeral concept, and widgets can be composed together to build more widgets. A widget can describe static as well as dynamic part of user interface. Rad offers widgets that are similar to Flutter widgets. Let's take a look,

Here's an example written using Rad:

```dart
class HomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: const Text("click me"),
        onTap: () => print("received a click!"),
      ),
    );
  }
}
```
How about that? if you're familiar with Flutter it don't even need an explanation.

## Geting started

1. Create a demo web app:
    - `dart create -t web-simple myapp`
  
    Having troubles? learn more [from official guide](https://dart.dev/tutorials/web/get-started)
    
2. Add Rad as dependency:
    - Open `pubspec.yaml` in newly created app folder and add `rad` to your dependencies:
      ```yaml
      dependencies:
        rad: 0.2.1
      ```

3. Import Rad widgets in your `main.dart`
    ```dart
    import 'package:rad/widgets.dart';
    ```

3. Create Rad app
    ```dart
    void main() {
      RadApp(
                            // 'output' is the id of div in your web/index.html
                            // framework will mount your app inside that div
                            // if you don't have a div with id 'output' in web/index.html, 
        targetId: "output", // you've to create it
                            // e.g
                            //    <body>
                            //      <div id="output"></div> 
                            //    ...
        child: GestureDetector(
          onTap: () {
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

For debugging a Dart web app, you've to setup a debugger for your IDE/editor. See Dart guide for [debugging web apps](https://dart.dev/web/debugging) and [tools that you can use](https://dart.dev/tools#general-purpose-tools). (remember you don't need Flutter SDK/or its plugins for using Rad).

If you happen to be using VS code,

- Install [VS code Dart plugin](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
- Create a `launch.json` inside `.vscode` folder - [see example](https://github.com/erlage/rad/blob/main/example/vscode/launch.json)
- Start your app in debug mode - see [this](https://code.visualstudio.com/docs/editor/debugging) for more

### Deployment

For getting a release build run `webdev build --release`. It'll generate a ready-to-deploy build of your app inside `build` folder. To customize your build, read [this official deployment guide](https://dart.dev/web/deployment). Alternatively, you can also follow [webdev documentation](https://dart.dev/tools/webdev).

## Styling widgets

Rad doesn't use a rendering engine to render a widget or anything like that. Rad widgets are mapped to HTML tags and composed together they way you describe them. This allows you to style them the way you want.

### Using CSS for styling

You can add CSS rules to widgets to style them. For example:
```dart
Container(
  styles: "css-class another-class",
  child: const Text("text inside a styled container"),
);
```
Note: Some widgets such as StatelessWidget don't have a `style` property.

### Size & Position

Some widgets have properties for their "size" or "position" or both. We refers to them as SizeProps & PositionProps respectively. PositionProps includes `left`, `right`, `top` and `bottom` properties while `width` and `height` are SizeProps.

Widgets that accept SizeProps also have an optional property `sizeUnit`. For PositionProps there's `positionUnit`. By default, `width: 20` will be mapped to `width: 20px`. But if you want to set width to some percentage of parent you can set `sizeUnit:` to **`MeasuringUnit.percentage`**. This will tell framework to map `width: 20` to `width: 20%`.

## Api reference

- [Rad library](https://pub.dev/documentation/rad/latest/rad/rad-library.html)
- [Widgets library](https://pub.dev/documentation/rad/latest/widgets/widgets-library.html)

## Widgets Index

### Main

- [RadApp](https://pub.dev/documentation/rad/latest/widgets/RadApp-class.html)

### Elements

- [Text](https://pub.dev/documentation/rad/latest/widgets/Text-class.html)

### Layout

- [Container](https://pub.dev/documentation/rad/latest/widgets/Container-class.html)
- [Stack](https://pub.dev/documentation/rad/latest/widgets/Stack-class.html)
- [Align](https://pub.dev/documentation/rad/latest/widgets/Align-class.html)
- [Positioned](https://pub.dev/documentation/rad/latest/widgets/Positioned-class.html)
  - [Positioned.fill](https://pub.dev/documentation/rad/latest/widgets/Positioned-class.html)
- [Overlay](https://pub.dev/documentation/rad/latest/widgets/Overlay-class.html)
  - [OverlayEntry](https://pub.dev/documentation/rad/latest/widgets/OverlayEntry-class.html)

### Misc

- [GestureDetector](https://pub.dev/documentation/rad/latest/widgets/GestureDetector-class.html)

### Abstract

- [StatelessWidget](https://pub.dev/documentation/rad/latest/rad/StatelessWidget-class.html)
- [StatefulWidget](https://pub.dev/documentation/rad/latest/rad/StatefulWidget-class.html)

## Contribution
Rad is a hobby project, feel free to open pull requests if you feel like missing a widget or something. Rad's core(src/core) is extremely small and straightforward. Having [basic knowledge of DOM](https://dart.dev/tutorials/web/low-level-html/connect-dart-html) & [Dart](https://dart.dev/guides/language/language-tour) is enough to implement widgets(src/widgets).

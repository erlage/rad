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

1. Create a demo app:
    - `dart pub global activate webdev`
    - `dart create -t web-simple myapp`
    - `cd myapp`
  
    Having troubles? learn more [from official guide](https://dart.dev/tutorials/web/get-started)
    
2. Add Trad as dependency:
    - Open `pubspec.yaml` and add `trad` to your dependencies:
      ```yaml
      dependencies:
        trad: 0.0.3
      ```

3. Import Trad widgets in your `main.dart`
    ```dart
    import 'package:trad/widgets.dart';
    ```

3. Create Trad app
    ```dart
    void main() {
      TradApp(
        targetId: "output",
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

3. Run `webdev serve` and follow onscreen instructions

## Debugging

Tooling in Dart is awesome. It's one of the reason I stopped Typescript. [Here's how](https://dart.dev/tools) you'd setup your favorite editor/IDE. If you happen to be using VS code you can head over to [Setting up editor](https://dart.dev/tools/vs-code). 
Remember Trad is a web-framework and you don't have to install Flutter/or its plugins for it to work.

# Styling widgets

## Using CSS

You can add CSS rules to widgets to style them. For example:
```dart
Container(
  style: "css-class another-class",
  child: const Text("styled text"),
);
```
Note that some widgets such as StatelessWidget don't have a `style` parameter.

## Sizing & Positioning units

Some widgets have parameters for their "size" or "position" or both. We refers to them as Sizing & Positioning props.

Positioning props includes `left`, `right`, `top` and `bottom` parameters while `width` and `height` are Sizing props.

Widgets that accept sizing props also have a optional parameter `sizingUnit`. For positioning props there's `positioningUnit`.

By default, `width: 20` will be mapped to `width: 20px`. But if you want to set width to some percentage of parent you can set `sizingUnit: MeasuringUnit.percentage`.

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

### Misc

- [GestureDetector](https://pub.dev/documentation/trad/latest/widgets/GestureDetector-class.html)

## Abstract

- [StatelessWidget](https://pub.dev/documentation/trad/latest/trad/StatelessWidget-class.html)
- [StatefulWidget](https://pub.dev/documentation/trad/latest/trad/StatefulWidget-class.html)


## Contribution
Trad is a small project. It allows anyone with basic knowledge of Javascript & DOM to create their own custom widgets in matter of minutes. PRs are welcomed<3 if you feel like missing a widget or something.


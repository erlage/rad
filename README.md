# Tard

Tard is frontend framework for Dart. It's inspired from Flutter and shares same programming paradigm. Which means, again, you'll be working with Widgets and tress. Don't worry, widgets in Tard are similar to Flutter widgets but in many ways more flexible.

Let's take a look at one of the widget from Tard: 

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

- Tard doesn't render pixels to build Wigets instead it maps widgets to HTML elements(tags), and takes care of managing DOM as whole.

- Every widget has a optional `key` parameter. Which if not provided will be generated. Keys in Tard are global, and used both internally(to find objects) & in DOM(as value of id attribute of HTML element that a widget is mapped to)

## Get started

1. Create a demo app:
    - `dart pub global activate webdev`
    - `dart create -t web-simple myapp`
    - `cd myapp`
  
    Having troubles? learn more [from official guide](https://dart.dev/tutorials/web/get-started)
    
2. Add Tard as dependency:
    - Open `pubspec.yaml` and add `tard` to your dependencies:
      ```yaml
      dependencies:
        tard: 0.0.3
      ```

3. Import Tard widgets in your `main.dart`
    ```dart
    import 'package:tard/widgets.dart';
    ```

3. Create Tard app
    ```dart
    void main() {
      TardApp(
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
Remember Tard is a web-framework and you don't have to install Flutter/or its plugins for it to work.

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

- [Tard library](https://pub.dev/documentation/tard/latest/tard/tard-library.html)
- [Widgets library](https://pub.dev/documentation/tard/latest/widgets/widgets-library.html)

## Widgets Index

### Main

- [TardApp](https://pub.dev/documentation/tard/latest/widgets/TardApp-class.html)

### Elements

- [Text](https://pub.dev/documentation/tard/latest/widgets/Text-class.html)

### Layout

- [Container](https://pub.dev/documentation/tard/latest/widgets/Container-class.html)

### Misc

- [GestureDetector](https://pub.dev/documentation/tard/latest/widgets/GestureDetector-class.html)

## Abstract

- [StatelessWidget](https://pub.dev/documentation/tard/latest/tard/StatelessWidget-class.html)
- [StatefulWidget](https://pub.dev/documentation/tard/latest/tard/StatefulWidget-class.html)


## Contribution
Tard is a small project. It allows anyone with basic knowledge of Javascript & DOM to create their own custom widgets in matter of minutes. PRs are welcomed<3 if you feel like missing a widget or something.


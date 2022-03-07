# Rad

Rad is a frontend framework for Dart. It's inspired from Flutter and shares same programming paradigm. In Rad, applications are created using widgets. A widget can describe static as well as dynamic part of user interface. Widgets can be composed together to build more widgets and complex layouts. Rad widgets are similar to Flutter widgets. 

Let's take a look at an example written using Rad:

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

## Getting started

1. Create a demo web app:
    - `dart create -t web-simple myapp`
  
    Having troubles? learn more [from official guide](https://dart.dev/tutorials/web/get-started)
    
2. Add Rad as dependency:
    - Open `pubspec.yaml` in newly created app folder and add `rad` to your dependencies:
      ```yaml
      dependencies:
        rad: 0.3.0
      ```

3. Import Rad widgets in your `main.dart`
    ```dart
    import 'package:rad/rad.dart';
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

## Routing

Rad framework comes with a in-built Router that offers 

- Auto Routing
- Auto Deep linking
- Auto Single page experience (no page reloads when user hit forward/back buttons)

![Deep linking and Single page experience in action](https://github.com/erlage/rad/raw/main/example/routing/routing.gif)

Everything you're seeing in above demo, works out of the box. That is, you'll be using just the Navigator widget and framework will take care of wiring things up. Even if you've Navigators nested inside other Navigators, or your Navigators are placed somewhere deep inside Pages, framework will take care of finding them and routing requests to them when needed.


### Navigator widget

```dart
Navigator(
    
    // required

    routes: [
        ...
    ],

    
    // both are optional

    onInit: (NavigatorState state) {

    }

    onRouteChange: (String name) {

    }
)
```

Let's discuss these properties one by one,

### routes:[]

This property takes list of Routes. A Route is more like an isolated Page that Navigator can manage. To define a Route, there's actually a Route widget:

```dart
routes: [

    Route(name: "home", page: HomePage()),

    Route(name: "edit", page: SomeOtherWidget())

    ...
]
```
Above, we've defined two routes, home and edit. A Route widget simply wraps a another widget. Route widget has a `name` property, that is used to give Route a name. Route's name is helpful in finding route, and navigating to it when needed, from application side.

### NavigatorState

Navigator widget creates a state object. State object provides methods which you can use to jump between routes, pop routes and things like that. To access a Navigator's state object, there are two methods:

1. If widget from where you accessing NavigatorState is in child tree of Navigator then use `Navigator.of(context)`. This method will return NavigatorState of the nearest ancestor Navigator from the given `BuildContext`.

2. For accessing state in parent widget of Navigator, use `onInit` hook of Navigator:
    ```dart
    class SomeWidget extends StatelessWidget
    {
        @override
        build(context)
        {
            return Navigator(
                onInit: _onInit,
                ...
            )
        }

        _onInit(NavigatorState state)
        {
            // do something with state
        }
    }
    ```

### Jumping to a Route

Navigator in Rad won't stack duplicate pages on top of each other, instead it'll create a route page only once. To go to a route, use `open` method of Navigator state. We could've named it `push` but `open` conveys what Navigator actually do when you jump to a route. When you call `open`, Navigator will create route page if it's not already created. Once ready, it'll bring it tp the top.

```dart
Navigator.of(context).open(name: "home");
```

### Going back

To go to previously visited route, use `Navigator.of(context).back()`. Make sure to check whether you can actually go back by calling `canGoBack()` on state.

### Passing values between routes

Values can be passed to a route through `open` method.

```dart
Navigator.of(context).open(name: "home", values: "/somevalue"); // leading slash is important
```

Then on homepage, value can be accessed on home page using:

```dart
var value = Navigator.of(context).getValue("home");
// "somevalue"
```

Passing multiple values:

```dart
Navigator.of(context).open(name: "home", values: "/somevalue/profile/123");
```

On homepage,

```dart
var valueOne = Navigator.of(context).getValue("home"); // -> "somevalue"
var valueTwo = Navigator.of(context).getValue("profile"); // -> "123"
```

Cool thing about Navigator is that values passed to a route will presist during browser reloads. If you've pushed some values while opening a route, those will presist in browser history too. This means you don't have to parameterize your page content, instead pass values on `open`:

```dart
// rather than doing this
Route(name: "profile", page: Profile(id: 123));

// do this
Route(name: "profile", page: Profile());

// and when opening profile route
Navigator.of(context).open(name: "profile", value: "/123");

// on profile page
var id = Navigator.of(context).getValue("profile");
```

### onRouteChange hook:

This hooks gets called when Navigator opens a route. This allows Navigator's parent to do something when Navigator that it's enclosing has changed. for example, you could've a header and you can change active tab when Navigator's route has changed.

```dart
Navigator(
    onRouteChange: (name) => print("changed to $name");
    ...
);
```

That's pretty much it. Source of demo shown at top of this section can be found in example/routing folder. 

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

Rad is a hobby project. Core(src/core) of this framework is extremely small and straightforward. Having just the [basic knowledge of DOM](https://dart.dev/tutorials/web/low-level-html/connect-dart-html) & [Dart](https://dart.dev/guides/language/language-tour) is enough to implement widgets(src/widgets). 


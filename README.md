# Rad

Rad is a frontend framework for Dart. It's inspired from Flutter and shares same programming paradigm. In Rad, applications are created using widgets. A widget can describe static as well as dynamic part of user interface. Widgets can be composed together to build more widgets and complex layouts. Rad widgets are similar to Flutter widgets. 

Let's take a look at an example written using Rad:

```dart
class HomePage extends StatelessWidget
{
  @override
  build(context) {
    return Container(
      child: GestureDetector(
        child: Text("click me"),
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
        rad: 0.4.0
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
- Create a `launch.json` inside `.vscode` folder - [see example](https://github.com/rad-framework/examples/raw/main/vscode/launch.json)
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

### Size properties

Some widgets have properties that can be used to give these widgets a predefined size. These properties are: width, height, margin and padding. These properties are directly mapped to CSS properties. If you're familer with CSS, below example will explain what we mean:
```dart
Container(
  width: "10px",
  height: "20px",
);
```
These properties allows you to pass literally anything:
```dart
Container(
  width: "10%",
  height: "20px",
);
```
There's also a less-verbose way. All widgets that has width and height properties also has a `size` property: 
```dart
Container(
  size: "10% 20px",
  // syntax :- size: "width height"
);
```
### Position properties

Similar to size properties there are top, right, bottom, left properties that deals with position of a widget.
```dart
Positioned(
  top: "10px",
  left: "20px",
);
```
And there's a optional `position` property:
```dart
Positioned(
  positon: "10px _ _ 20px",
  // syntax :- position: "top right bottom left"

  // underscore means ignore this
  // applies to size prop as well.
);
```

## Routing

Rad framework comes with a in-built Router that offers 

- Auto Routing
- Auto Deep linking
- Auto Single page experience (no page reloads when user hit forward/back buttons)

![Deep linking and Single page experience in action](https://github.com/rad-framework/examples/raw/main/routing/routing.gif)

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

### routes[]

This property takes list of Routes. A Route is kind of an isolated Page that Navigator can manage. To define a Route, there's actually a Route widget:

```dart
routes: [

    Route(name: "home", page: HomePage()),

    Route(name: "edit", page: SomeOtherWidget())

    ...
]
```
Above, we've defined two routes, home and edit. A Route widget simply wraps a another widget. Route widget has a `name` property, that is used to give Route a name. Route's name is helpful in finding route from application side, and navigating to it when needed.

### NavigatorState

Navigator widget creates a state object. State object provides methods which you can use to jump between routes, pop routes and things like that. To access a Navigator's state object, there are two methods:

1. If widget from where you accessing NavigatorState is in child tree of Navigator then use `Navigator.of(context)`. This method will return NavigatorState of the nearest ancestor Navigator from the given context.

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

Navigator in Rad doesn't stack duplicate pages on top of each other, instead it'll create a route page only once. To go to a route, use `open` method of Navigator state. When you call `open`, Navigator will create route page if it's not already created. Once ready, it'll bring it to the top.

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

Then on homepage, value can be accessed using:

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

## Widgets Index

### Main

- [RadApp](https://pub.dev/documentation/rad/latest/rad/RadApp-class.html)

### Navigator

- [Navigator](https://pub.dev/documentation/rad/latest/rad/Navigator-class.html)
- [Route](https://pub.dev/documentation/rad/latest/rad/Route-class.html)

### Layout

Boxes

- [Container](https://pub.dev/documentation/rad/latest/rad/Container-class.html)
- [SizedBox](https://pub.dev/documentation/rad/latest/rad/SizedBox-class.html)

Alignment

- [Align](https://pub.dev/documentation/rad/latest/rad/Align-class.html)
- [Center](https://pub.dev/documentation/rad/latest/rad/Center-class.html)
- [Positioned](https://pub.dev/documentation/rad/latest/rad/Positioned-class.html)

Overlays

- [Stack](https://pub.dev/documentation/rad/latest/rad/Stack-class.html)

- [Overlay](https://pub.dev/documentation/rad/latest/rad/Overlay-class.html)
- [OverlayEntry](https://pub.dev/documentation/rad/latest/rad/OverlayEntry-class.html)

Flex

- [Row](https://pub.dev/documentation/rad/latest/rad/Row-class.html)
- [Column](https://pub.dev/documentation/rad/latest/rad/Column-class.html)
- [Flex](https://pub.dev/documentation/rad/latest/rad/Flex-class.html)
- [Flexible](https://pub.dev/documentation/rad/latest/rad/Flexible-class.html)
- [Expanded](https://pub.dev/documentation/rad/latest/rad/Expanded-class.html)
- [Spacer](https://pub.dev/documentation/rad/latest/rad/Spacer-class.html)

### Misc

- [GestureDetector](https://pub.dev/documentation/rad/latest/rad/GestureDetector-class.html)

### Abstract

- [StatelessWidget](https://pub.dev/documentation/rad/latest/rad/StatelessWidget-class.html)
- [StatefulWidget](https://pub.dev/documentation/rad/latest/rad/StatefulWidget-class.html)

### Elements

- [Text](https://pub.dev/documentation/rad/latest/rad/Text-class.html)
- [MarkUp](https://pub.dev/documentation/rad/latest/rad/MarkUp-class.html)

## Contribution

Rad is a hobby project. Core(src/core) of this framework is extremely small and straightforward. Having just the [basic knowledge of DOM](https://dart.dev/tutorials/web/low-level-html/connect-dart-html) & [Dart](https://dart.dev/guides/language/language-tour) is enough to implement widgets(src/widgets). Feel free to open issue/PRs but do note that this framework is in its initial development phase which means anything can change anytime.

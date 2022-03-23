## Getting started

1. Create a demo web app:
    - `dart create -t web-simple myapp`
  
    Having troubles? learn more [from official guide](https://dart.dev/tutorials/web/get-started)
    
2. Add Rad as dependency:
    - Open `pubspec.yaml` in newly created app folder and add `rad` to your dependencies:
      ```yaml
      dependencies:
        rad: 0.7.0
      ```

3. Import Rad widgets in your `main.dart`
    ```dart
    import 'package:rad/rad.dart';
    ```

3. Create App
    ```dart
    void main() {
      RadApp(
                            // 'output' is the id of div in your web/index.html
                            // framework will mount your app inside that div
                            // if you don't have a div with id 'output' in web/index.html, 
        targetKey: "output", // you've to create it
                            // e.g
                            //    <body>
                            //      <div id="output"></div> 
                            //    ...
        child: Text("hello"),
      );
    }
    ```

3. Run `webdev serve` and follow on-screen instructions

### Debugging

For debugging a Dart web app, you've to setup a debugger for your IDE/editor. See Dart guide for [debugging web apps](https://dart.dev/web/debugging) and [tools that you can use](https://dart.dev/tools#general-purpose-tools). (remember you don't need Flutter SDK/or its plugins for using Rad).

If you happen to be using VS code,

- Install [VS code Dart plugin](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
- Create a `launch.json` inside `.vscode` folder - [see example](https://github.com/erlage/rad/raw/main/example/vscode/launch.json)
- Start your app in debug mode - see [this](https://code.visualstudio.com/docs/editor/debugging) for more

### Deployment

For getting a release build run `webdev build --release`. It'll generate a ready-to-deploy build of your app inside `build` folder. To customize your build, read [this official deployment guide](https://dart.dev/web/deployment). Note that optimization level can be controlled. Refer to [dart2js docs](https://dart.dev/tools/dart2js) for options available. Alternatively, you can also follow [webdev documentation](https://dart.dev/tools/webdev).
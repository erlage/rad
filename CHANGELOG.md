## 1.6.0

#### New

- (Added): Navigator.onDispose callback.
- (Added): MountOptions to runApp(for controlling inline-styles etc).

#### Bug Fixes

- (Fixed): Router matching non-exact parts.
- (Fixed): Router pushing incorrect paths(window.location).
- (Fixed): Router ignoring initial on-pop event.
- (Fixed): InheritedWidget: Orphan dependents are not getting cleaned up.
- (Fixed): InheritedWidget: Dispatch order of update notifications is undefined(now LIFO).
- (Fixed): RenderElement: visitAncestorElements() traversing temporary elements.
- (Fixed): RenderElement: traverseAncestorElements() traversing temporary elements.
- (Fixed): RenderElement: Call order of didRender & didUpdate is undefined for nested elements.
- (Fixed): RouterRenderElement: Orphan dependents are not getting cleaned up.

## 1.5.0

**Visual-JSX**, *a Dart to JSX Visualizer*.

Visual-JSX is a feature designed to make managing HTML code written in Dart easier. It transforms HTML widgets into a visually appealing, JSX-like syntax, making it easier to understand and maintain your HTML widgets. You'll find it extremely helpful as a visual aid when working with HTML inside the Dart code.

**HTML2Rad**, *a streamlined method for importing HTML templates into Rad*.

No more manual porting of HTML templates to HTML widgets! HTML2Rad allows you to convert HTML markup directly into Rad's HTML widgets with few clicks. Both Visual-JSX and HTML2 are aimed at enhancing development experience and increasing productivity. These two features are published together as [an extension](https://marketplace.visualstudio.com/items?itemName=erlage.rad) that's available for install only on Visual Studio Code(for now). Please refer to [this document](https://github.com/erlage/rad/tree/main/packages/text_editor_vscode_extension#readme) for usage details. 

### Previews

-   <details>
    <summary>Click to See Visual-JSX's Preview</summary>
        
    ![Visual-JSX Preview](https://github.com/erlage/rad/blob/47591df594be5d993d5a813667ef9d372ec80f10/packages/text_editor_vscode_extension/art/peek1.gif?raw=true)
    </details>

-   <details>
    <summary>Click to See HTML2Rad's Preview</summary>
        
    ![HTML2Rad Preview](https://github.com/erlage/rad/blob/47591df594be5d993d5a813667ef9d372ec80f10/packages/text_editor_vscode_extension/art/peek2.gif?raw=true)
    </details>

#### Bug fixes

- (Fixed): Router incorrectly pushing the Route.name to the address bar instead of the Route.path.
- (Fixed): Calling `NavigatorState.open` inside `onInit`, results in multiple routes being left open.

## 1.4.0

**Refs**, *an easy and predictable way for accessing DOM nodes*.

Inspired from Callback-Refs in React, Refs in Rad provides an easy and predictable way to access DOM elements that are associated with Rad widgets. Normally Rad takes cares of creating and updating DOM for you but there are many reasons why you would want to access the actual DOM elements. Common use-cases are managing focus (critical for accessibility) and triggering imperative animations.

## 1.3.0

**Hooks**, *use features such as state inside widget-functions*.

Hooks(inspired by React's Hooks) lets you use state and other features without writing classes(such as StatefulWidget). This release includes few ready-to-use hooks and a easy yet powerful Hooks API that you can use to create your own custom hooks. We've also released a hooks package containing implementations of commonly used React Hooks(see [rad_hooks](https://pub.dev/packages/rad_hooks)).

## 1.2.0

**RenderEvents**, *a event system for RenderElements*.

RenderEvents are the events that framework will emit when it interacts with a RenderElement. Just like we can add event listeners for user interactions on DOM elements, we can now add event listeners for framework interactions on RenderElements. Similar to DOM events, we've different types of RenderEvents for different types of interactions which are listed below:

- `didRender` is a event that's emitted after framework finishes rendering the output of [render](https://pub.dev/documentation/rad/latest/rad/RenderElement/render.html) to the DOM.
- `didUpdate` is a event that's emitted after framework finishes rendering the output of [update](https://pub.dev/documentation/rad/latest/rad/RenderElement/update.html) to the DOM.
- `willUnMount` is a event that's emitted when framework is about to remove the widget from the DOM.
- `didUnMount` is a event that's emitted after framework finishes removing the widget from the DOM.

RenderElements can decide to listen to a particular or all render events by adding event listeners. 

Comparing RenderEvents with DOM events, there are few differences & restrictions:

- RenderEvents do not have capture/bubble phase.
- RenderEvents are meant to be listened internally inside RenderElements.
- Listeners for RenderEvents can be attached only during initial render, and cannot be updated.

These restrictions are temporary and we'll lift them when needed. 

RenderEvents are meant to solve the problem of limited control over lifecycle in RenderElements. Previously we were providing a sub-class `WatchfulRenderElement` with hardcoded lifecycle. Now, using the new RenderEvents API, you can add as much or as little lifecycle as you want, to any RenderElement(widget). This new API effectively makes `WatchfulRenderElement` obsolete but we'll keep it for backward compatibility at zero-cost(it's also using the new RenderEvents API from now on).

#### Bug fixes

- (Fixed): Renderer reconciling all sibling widgets on dependent updates(sometime disposing siblings because of that).

## 1.1.0

#### New

- (Added): `State.afterMount`: Gets called after framework finishes rendering widget to DOM. 
- (Added): `State.afterUpdate`: Gets called after framework finishes re-rendering widget to DOM. 
- (Added): `State.afterUnMount`: Gets called after framework finishes removing widget from DOM.
- (Added): `State.afterMount`: Gets called after framework finishes rendering widget to DOM. 
- (Added): `State.afterUpdate`: Gets called after framework finishes re-rendering widget to DOM. 
- (Added): `State.afterUnMount`: Gets called after framework finishes removing widget from DOM.
- (Added): `WatchfulRenderElement.afterUpdate`: Gets called after framework finishes re-rendering widget to DOM.
- (Added): `WatchfulRenderElement.dispose`: Gets called after framework is about to remove it from DOM.
- (Added): [`EmittedEvent.nativeEvent`](https://pub.dev/documentation/rad/latest/rad/EmittedEvent/nativeEvent.html) that returns underlying native event.

#### Bug fixes

- (Fixed): `WatchfulRenderElement.afterUnMount` getting called before framework finishes removing widget from DOM(while it should get called after the complete removal of widget)

## 1.0.2

#### Bug fixes

- (Fixed): Value not setting/updating correctly on following Input widgets: InputUrl, InputTime, InputTelephone, InputSearch, InputRange, InputPassword, InputNumber, InputMonth, InputEmail, InputText, InputDateTimeLocal, InputDate and InputColor.
- (Fixed): InputHidden missing from public API.

## 1.0.1

- Stable release.

# Pre-stable changes

## 1.0.1-rc.2

This release was not published.

- Re-added child property from all HTML widgets.
- Removed tabIndex, contentEditable & draggable property from global attributes.

## 1.0.1-rc.1

- Stable release candidate

## 0.10.0

## New

- Added RawEventDetector widget.
- Added `value` property to TextArea widget.

## Changes

- Removed child property from all HTML widgets.
- Removed textContents, rawContents from DomNodePatch.
- **Important***: Changes made in rc(s) `1.0.0-rc.1` & `1.0.0-rc.1` are available in `0.10.0`.

## 1.0.0-rc.2

### New

- Added `additionalAttributes` property to all HTML widgets.
- Ability to add/update/remove meta information(meta tags) from within app's context.

### Changes

- Removed `GlobalKey`.
- Removed `dataAttributes` property from HTML widgets. Use `additionalAttributes` instead.

## 1.0.0-rc.1

### New

- Support for multiple Navigators at the same depth.
- Added `Widget.shouldUpdateWidget` & `Widget.shouldUpdateWidgetChildren` hooks. Both `shouldUpdateWidget` & `shouldUpdateWidgetChildren` hooks, combined together, produces semantics similar to React's `shouldUpdateComponent`. (see API docs for more).

### Changes

- Removed `LocalKey`.
- Removed `Widget.createConfiguration` & `Widget.isConfigurationChanged`.
- Removed internal imports library(`package:rad/widgets_internals`). 
- Changed `Navigator.of` signature(see API docs)
- Renamed:
    - `DomNodeDescription` to `DomNodePatch`.
    - HTML's property `contenteditable` to `contentEditable`.
    - HTML's `Blockquote` to `BlockQuote`.

### Core - Benchmarks

For the past couple of weeks, core has been subjected to extensive benchmark tests. These tests helped us a lot in discovering bottlenecks in the core. Both the benchmark results and the benchmarking tools are available in public:
- [See latest benchmark results](https://erlage.github.io/)
- [Or Run benchmarks on your machine](https://github.com/erlage/rad-benchmarks#running-benchmarks)

### Core - Architecture

Previously every `Widget` was creating a `BuildContext` and a `RenderObject`. Then internally to prevent direct DOM manipulation, Renderer was also creating a `RenderNode` for every widget(kind of Virtual DOM). Most of these pieces were mutable and to manage them framework was also creating a wrapper object called `WidgetObject` to wrap these objects into single object. With this re-write, we've removed all these messy objects from the core and what we're left with is two trees, widget-tree and a render-tree, and there are only two types of objects a widget must have:

- Widget (immutable node in widget tree that contains configuration for render elements)

- RenderElement (mutable node in render tree that contains lifecycle methods)

Unlike Elements in Flutter, RenderElements are not responsible for mounting or rendering actual DOM nodes. Instead RenderElements can tell the framework about the desired description of dom node that they want. How framework renders DOM and apply those descriptions is totally out of scope for render elements. A RenderElement can know its parent child relationships but how those child/parents are populated and linked to it are controlled by the framework. This way framework can optimise rendering behind the scenes without breaking APIs.

Second change is to Widget's Key property. I've decided to diverge from Flutter's Key model a bit. Unlike flutter, keys now only make sense in the context of the surrounding array of widgets and there are only two types of keys.

- Normal key: `Key('requires string value to create key')`

- Global key: `GlobalKey('requires unique string value to create key')`

Widgets with global key are registered in walker service and a global key can be used to find `RenderElement` associated with a widget using `WalkerService.getRenderElementAssociatedWithGlobalKey`. This is the **only difference** between a normal and GlobalKey.

## 0.9.0

### Core

- Core now generates noise-free markup. Previously every widget had a corresponding element in DOM. Now widgets can exists on their own in tree without ever creating a corresponding dom node. As a exception, Text widget is allowed to have a corresponding dom node(not a text node) because we allow styling and adding event listeners to contents of a text widget.

- There are number of changes to Public API but most of them are relevant to external packages that depend on core.

## 0.8.1

- Short syntax for HTML widgets.
- Minor bug fixes in documentation.

## 0.8.0

### New

- Support for running multiple apps on the same page.
- Widget keys(`Key`, ~~`LocalKey`~~ and ~~`GlobalKey`~~). (previously key was just a string)
- `AsyncRoute` and `EventDetector` widgets along with number of new HTML widgets.

### Changes

- All HTML widgets now has an `id` attribute.
- From now on, you've to use `runApp()` to bootstrap your apps. (see docs)
- Widget's keys are not String literals anymore. Use `Key`, `LocalKey`, or `GlobalKey`.
- `size` property has been removed from `Image` and `IFrame` widget.
- Getters `element` and `isRebuilding` has been removed from `StatefulWidget`.
- Following properties are changed:
    - `onClick` is renamed to `onClickAttribute`
    - `onClickEventListener` is renamed to `onClick`
    - `onInputEventListener` is renamed to `onInput`
    - `onChangeEventListener` is renamed to `onChange`
    - `onSubmitEventListener` is renamed to `onSubmit`
    - Signature for all `on*` callbacks has been changed to `void Function(EmittedEvent)`, previously it was `void Function (Event)`. `EmittedEvent` is a new type, compatible with `Event`. 

- Minor changes to imports:
    - `import/rad/rad.dart` - Main library
    - `import/rad/widgets_html.dart` - Library that exports HTML widgets
    - `import/rad/widgets_async.dart` - Library that exports async widgets such as `FutureBuilder`
    - `import/rad/widgets_internals.dart` - Library that exports low-level types/objects.


### Core Changes

- Important additions to core are event delegation, element tree, batched DOM updates and a brand new algorithm for matching widgets during updates(new algorithm: `O(n)`, previous algorithm: `O(n²)`). 

- A new widget `EventDetector` is also added that leverages core's event-delegation to allow you to register event listeners both in capture and bubbling phase. 

- `beforeMount` hook is now removed. Previously `render` hook gets called after `beforeMount` as widgets are using `render` hook to decorate their corresponding element in DOM. Now with batched DOM updates, widget will not be able to access actual element since mount will happen at a later stage.

- If a widget wants to decorate actual DOM element then it can optionally return a `ElementDescription` object which will be operated on real DOM element when DOM updates are dispatched. Similarly widget can return updated `ElementDescription` object on `update` hook.

## 0.7.0

### New

- ListView widget. Along with `ListView.builder` version that build items in a lazy fashion. This widget can be used to create infinite scrolling lists/pages.

### Changes

- key is now a named parameter. Use `super(key: key)` instead of `super(key)`
- Brought sanity to Navigator's values API. Now instead of passing values as string, use Map to pass values.

### Improvements

- Added Canvas widget for HTML's Canvas tag.

- Added `child` property to all MarkUp tag widgets.

- Added `didChangeDependencies` hook to StatefulWidget.

- Navigator:
    - Uri encoding/decoding for values passed.
    - Ability to look up specific instance in ancestors.
    - Fixed Uri replacement issue when app is installed under sub dir(path).

## 0.6.2

### New!

- Added InheritedWidget

### Changes

- 'App' widget has been renamed to 'RadApp'.
- StatelessProvider widget has been removed. Alternative: InheritedWidget 

### Core update

- Core is now able short-circuit widget rebuilds. This makes Rad a blazingly fast frontend framework.
- Now keys can be used to distinguish between correct widgets while rebuilding. Something like that: https://www.youtube.com/watch?v=kn0EOS-ZiIc
- From now, `const` constructors can drastically improves performance. Try to use them where possible.
    To get linter help on this, use following rules in your `analysis_options.yaml`
    ```yaml
    linter:
        rules:
            - prefer_const_constructors
            - prefer_const_declarations
            - prefer_const_constructors_in_immutables
            - prefer_const_literals_to_create_immutables
    ```

## 0.5.4

- Patch Navigator initial Render

## 0.5.2

- Added innerText, onClick and onClickEventHandler property for HTML tags.

## 0.5.1

- Update public API

## 0.5.0

### New widgets

- StatelessProvider
- HTML tag widgets
- FutureBuilder, StreamBuilder, ValueListenableBuilder

### Changes

- Following widgets are removed: Center, Align, Positioned, Center, Flex,
Row, Column, Stack, Spacer, Expanded, Flexible, Align, Container, SizedBox.

### Core Update

Major changes:

- Both Widgets and RenderObjects are now immutable
- Plus, A RenderObject is created exactly once.

For above two things, we've delegated some of the mutable parts to DOM
and a super lightweight widget configuration API is added that handles
mutability on widget's constructor level

Improvements:

- Added findAncestor* methods to BuildContext
- Navigator and GestureDetector are now subclassing StatefulWidget
- A lot of mess has been cleaned. Including 'late final' modifier combos
that has problems with dart2js. 

### Comments

A lot has been changed. We've now reached our first milestone. State management
that's required to build real world apps is complete. I'm currently going back 
to create web version of my Flutter app using this framework and see where it can
be improved.

## 0.4.0

### New widgets!

- Center widget for alignment.

- MarkUp widget that allows passing arbitrary content to DOM.

- SizedBox widget for creating a fixed size box.

- Row, Column, and Flex widgets for flex layout.

- Flexible and Expanded widgets for flex items.

- Spacer widget for adding extra space in flex layout.

- Navigator widget for Navigation and routing. 

    Navigator supports:
    - Auto Routing
    - Auto Deep linking
    - Single page application experience(no page reloads)
    
### Changes

- Removed Align.center() constructor. 'Center' is added as drop-in replacement.

- Removed Text widget's `isHtml` prop. Alternative: 'MarkUp' widget.

### Move toward less verbose syntax:

- Box size properties namely width, height, top, right, bottom, left, margin, padding accept only `String` values. 
- Explicit properties that deals with measurement unit such as "positionUnit" and "sizeUnit" are removed.

```dart
// previously
Container(
    width: 10,
    height: 20,
    sizeUnit: MeasuringUnit.percent
)

// now
Container(
    width: "10%",
    height: "20%",
)

// this can be done in a even more less verbose way
Container(
    size: "10% 20%",
)

// previously
Positioned(
    top: 10,
    left: 20,
)

// now
Positioned(
    top: "20px",
    left: "20px",
)

// or
Positioned(
    position: "20px _ _ 20px",
)

// syntax is
// position: "top right bottom left",
// values that are set to '_' will be skipped
```

This change brings three good things:

- Clean and less verbose code.
- Flexibility. Developer can set literally any value.
- Performance! since this also removes a lot of complexity on Framework side.

Please refer to "Size and Position" section of project's readme to learn more about these changes.  

### Small improvements

- Added `rebuildOnUpdate` hook to StatefulWidget. 

Previously StatefulWidget always ignore setState() or any change in state in parent tree. Now you can override rebuildOnUpdate hook and return true if you want to rebuild StatefulWidget when something changes in parent tree. Note, rebuilding won't dispose your widget, it'll simply call build() method of your StatefulWidget to get up-to-date interface, and update DOM if required. 

This hook helps a lot when you've a StatefulWidget in a Navigator's page, and you want to rebuild that widget when user comes back from a different page. Returning true from rebuildOnUpdate hook will make sure that end user isn't looking at a stalled interface.

## 0.3.0

### Update

- New shorthand `Align.center`. It has same semantics as of Flutter's `Center` widget.

- Container widget:
    - Added `margin` property, that let's you set margin around Container.
    - Added `padding` property, that let's you set padding space inside Container.

- Custom alignments for positioning a widget on desired locations.
    ```dart
    Align(
        alignment: Alignment(80, 40); // top 80% & left 40% 
        ...
    ```

### Changes

- `sizingUnit` is renamed to `sizeUnit`
- `positioningUnit` is renamed to `positionUnit`

### Core update

- Widget are now smart enough to issue changes to DOM only when required. Previously a widget always issue update to part of its interface that might or might not have affected by state change in parent because this is the easiest way to ensure that its corresponding DOM is always up-to-date. From now, widgets will issue updates to DOM only if their description has changed. 

    For example, in below code, Text widget will never issue a update no matter how many times you do toggle.

    ```dart
    Text(isClicked ? "hey" : "hey")
    ```
    
    This feature gets more effective in nested widgets. Take a look at another example,

    ```dart
    Align(
        alignment: isClicked ? Alignment.center : Alignment.center,
        child: Container(
            style: isClicked ? "red" : "red",
            child: Text(isClicked ? "hey" : "hey"),
        ),
    ),
    ```

    Above Align widget will affect DOM only once when its being built. It'll never issue a DOM update during rest of its lifetime.



## 0.2.1

### Update

- Allow creation of minified and optimized builds.

## 0.2.0 

### Core update

- Sub-tree rebuilds are now removed. Previously, `setState` forces all child widgets to dispose and rebuild themselves. From now, only widgets that requires update, will update only parts of their interface that that might be affected by state change in their parent.

- Framework now allow Stateful widgets nested inside other stateful widgets to preserve their state even when their parent state has changed.

## 0.1.0

### Update

- Added: Overlay widget

### Changes

- GestureDetector
    - `onTapEvent` property is added in-place of `onTap`
    - `onTap` now handles `VoidCallback`s

## 0.0.1

- Initial release

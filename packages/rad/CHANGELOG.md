## 1.5.0

**Visual-JSX**, *a Dart to JSX Visualizer*.

Visual-JSX is a feature designed to make managing HTML code written in Dart easier. It transforms HTML widgets into a visually appealing, JSX-like syntax, making it easier to understand and maintain your HTML widgets. You'll find it extremely helpful as a visual aid when working with HTML widgets inside the Dart code.
<br>

**HTML2Rad**, *a streamlined method for importing HTML templates into Rad*.

No more manual porting of HTML templates to HTML widgets! HTML2Rad allows you to convert HTML markup directly into Rad's HTML widgets with few clicks. Both Visual-JSX and HTML2 enhances development experience for developers working with the Rad Framework so we decided to bundle them together in one extension that users can install in Visual Studio Code(text editor).
<br>

#### Bug fixes

- (Fixed): Router incorrectly pushing the Route.name to the address bar instead of the Route.path.
- (Fixed): Calling `NavigatorState.open` inside `onInit`, results in multiple routes being left open.

### Previews

-   <details>
    <summary>Click to See Visual-JSX's Preview</summary>
        
    ![Visual-JSX Preview](https://photogram.erlage.com/tmp/rad_vscode_peek1.gif)
    </details>

-   <details>
    <summary>Click to See HTML2Rad's Preview</summary>
        
    ![HTML2Rad Preview](https://photogram.erlage.com/tmp/rad_vscode_peek2.gif)
    </details>

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

- (Fixed) Renderer reconciling all sibling widgets on dependent updates(sometime disposing siblings because of that).

## 1.1.0

#### Added following lifecycle methods to [`State`](https://pub.dev/documentation/rad/latest/rad/State-class.html):

- `afterMount`: Gets called after framework finishes rendering widget to DOM. 
- `afterUpdate`: Gets called after framework finishes re-rendering widget to DOM. 
- `afterUnMount`: Gets called after framework finishes removing widget from DOM.

#### Added following lifecycle methods to [`WatchfulRenderElement`](https://pub.dev/documentation/rad/latest/rad/WatchfulRenderElement-class.html):

- `afterUpdate`: Gets called after framework finishes re-rendering widget to DOM.
- `dispose`: Gets called after framework finishes removing widget from render tree and is about to remove it from DOM.

#### Others

- Added a public getter [`EmittedEvent.nativeEvent`](https://pub.dev/documentation/rad/latest/rad/EmittedEvent/nativeEvent.html) that returns underlying native event(wrappee object).

#### Bug fixes

- (Fixed) `WatchfulRenderElement.afterUnMount` getting called before framework finishes removing widget from DOM(while it should get called after the complete removal of widget)

## 1.0.2

- (Fixed) Value not setting/updating correctly on following Input widgets: InputUrl, InputTime, InputTelephone, InputSearch, InputRange, InputPassword, InputNumber, InputMonth, InputEmail, InputText, InputDateTimeLocal, InputDate and InputColor.

- (Fixed) InputHidden missing from public API.

## 1.0.1

- Stable release.
- If curious, you can checkout development [change log here](https://github.com/erlage/rad/blob/main/CHANGELOG.md).

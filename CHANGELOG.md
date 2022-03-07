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
- `positioninUnit` is renamed to `positionUnit`

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

- Sub-tree rebuilds are now removed. Previously, `setState` forces all childs widgets to dispose and rebuild themselves. From now, only widgets that requires update, will update only parts of their interface that that might be affected by state change in their parent.

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

## 0.3.0

Update

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

Changes

- `sizingUnit` is renamed to `sizeUnit`
- `positioninUnit` is renamed to `positionUnit`

Core update

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

Update

- Allow creation of minified and optimized builds.

## 0.2.0 

Core update

- Sub-tree rebuilds are now removed. Previously, `setState` forces all childs widgets to dispose and rebuild themselves. From now, only widgets that requires update, will update only parts of their interface that that might be affected by state change in their parent.

- Framework now allow Stateful widgets nested inside other stateful widgets to preserve their state even when their parent state has changed.

## 0.1.0

Update

- Added: Overlay widget

Changes

- GestureDetector
    - `onTapEvent` property is added in-place of `onTap`
    - `onTap` now handles `VoidCallback`s

## 0.0.1

- Initial release


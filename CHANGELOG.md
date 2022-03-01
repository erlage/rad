## 0.2.1

- Allow creation of minified and optimized builds.

## 0.2.0

- Core update 

    - Sub-tree rebuilds are now removed. Previously, `setState` forces all childs widgets to dispose and rebuild themselves. From now, only widgets that requires update, will update only parts of their interface that that might be affected by state change in their parent.

    - Framework now allow Stateful widgets nested inside other stateful widgets to preserve their state even when their parent state has changed.

## 0.1.0

- Add: Overlay widget

- Improve: GestureDetector
    - `onTapEvent` property is added in-place of `onTap`
    - `onTap` now handles `VoidCallback`s

## 0.0.1

- Initial release


## 1.1.0

- Added following lifecycle methods to StatefulWidget's [`State`](https://pub.dev/documentation/rad/latest/rad/State-class.html):

    - `afterMount`: Gets called after framework finishes rendering widget to DOM. 
    - `afterUpdate`: Gets called after framework finishes re-rendering widget to DOM. 
    - `afterUnMount`: Gets called after framework finishes removing widget from DOM.

- Added following lifecycle methods to [`WatchfulRenderElement`](https://pub.dev/documentation/rad/latest/rad/WatchfulRenderElement-class.html):

    - `afterUpdate`: Gets called after framework finishes re-rendering widget to DOM. 
    - `dispose`: Gets called after framework finishes removing widget from render tree and is about to remove it from DOM.
    - `afterUnMount`: Gets called after framework finishes removing widget from DOM.

- Added a public getter [`EmittedEvent.nativeEvent`](https://pub.dev/documentation/rad/latest/rad/EmittedEvent/nativeEvent.html) that returns underlying native event(wrappee object).

#### Bug fixes

- (Fixed) `WatchfulRenderElement.afterUnMount` getting called before framework finishes removing widget from DOM(while it should get called after the complete removal of widget)

## 1.0.2

- (Fixed) Value not setting/updating correctly on following Input widgets: InputUrl, InputTime, InputTelephone, InputSearch, InputRange, InputPassword, InputNumber, InputMonth, InputEmail, InputText, InputDateTimeLocal, InputDate and InputColor.

- (Fixed) InputHidden missing from public API.

## 1.0.1

- Stable release.

See pre-releases prior to this version for changelog entries.

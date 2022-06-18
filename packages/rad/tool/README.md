## Dev-Note

### Styles builder:

This utility converts CSS files(located in lib/src/css folder) to Dart code which then framework can inject in the DOM. 

If you want to add CSS into the framework for your widget then do that in .css files(inside lib/src/css/) or you can create a new .css file anywhere inside css folder.

After adding css(file or edit), run `dart run build_runner build` to build files.

### Renderer Optimizations test:

This utility performs tests after making hinted mutations such as adding/removing specific optimizations on source to ensure that our renderer implementation is correct with and without optimizations. See workflows/renderer_optimizations_test.yml for more.

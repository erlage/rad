## Dev-Note

### Styles builder:

This utility converts CSS files(located in lib/src/css folder) to Dart code which then framework can inject in the DOM. 

If you want to add CSS into the framework for your widget then do that in .css files(inside lib/src/css/) or you can create a new .css file anywhere inside css folder.

After adding css(file or edit), run `dart run build_runner build` to build files.

### Reconciler tests:

This utility performs tests after making hinted mutations such as adding/removing specific optimizations on source to ensure that our reconciler works correct, both with and without optimizations. See reconciler.yml workflow for more.

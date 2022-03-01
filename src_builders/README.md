## Dev-Note

This utility converts CSS files(located in lib/src/css folder) to Dart code which then framework can inject in the DOM. 

If you want to add CSS into the framework for your widget then do that in .css files(inside lib/src/css/) or you can create a new file .css file anywhere inside css folder.

After adding css(file or edit), run `dart run build_runner build` to build files.

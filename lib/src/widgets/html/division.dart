import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

class Division extends MarkUpTagWithGlobalProps {
  const Division({
    String? key,
    String? title,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    String? innerText,
    List<Widget>? children,
  }) : super(
          key: key,
          title: title,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          innerText: innerText,
          children: children,
        );

  @override
  get concreteType => "$Division";

  @override
  get correspondingTag => DomTag.division;

  @override
  createRenderObject(context) => _DivisionRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _DivisionRenderObject extends RenderObject {
  const _DivisionRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant MarkUpGlobalConfiguration configuration,
  ) {
    MarkUpGlobalProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant MarkUpGlobalConfiguration oldConfiguration,
    required covariant MarkUpGlobalConfiguration newConfiguration,
  }) {
    MarkUpGlobalProps.clear(element, oldConfiguration);
    MarkUpGlobalProps.apply(element, newConfiguration);
  }
}

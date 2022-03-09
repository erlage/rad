import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

class Division extends MarkUpTagWithGlobalProps {
  const Division({
    String? id,
    String? title,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    List<Widget>? children,
  }) : super(
          id: id,
          title: title,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          children: children,
        );

  @override
  String get concreteType => "$Division";

  @override
  DomTag get correspondingTag => DomTag.div;

  @override
  isConfigurationChanged(covariant MarkUpGlobalConfiguration oldConfiguration) {
    return super.isChanged(oldConfiguration);
  }

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

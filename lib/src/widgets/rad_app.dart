import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/dom_node_description.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A Simple App Widget that takes as much space as its parents allowed it to.
///
class RadApp extends Widget {
  final Widget child;

  const RadApp({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  List<Widget> get widgetChildren => [child];

  @override
  String get widgetType => 'RadApp';

  @override
  DomTagType get correspondingTag => DomTagType.division;

  @override
  createRenderObject(context) => AppWidgetRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| description(never changes for rad app widget)
|--------------------------------------------------------------------------
*/

const _description = DomNodeDescription(
  attributes: {
    Attributes.classAttribute: Constants.classRadApp,
  },
);

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class AppWidgetRenderObject extends RenderObject {
  const AppWidgetRenderObject(BuildContext context) : super(context);

  @override
  render({required configuration}) => _description;
}

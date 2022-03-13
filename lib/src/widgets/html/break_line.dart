import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

class BreakLine extends Widget {
  const BreakLine({String? key}) : super(key);

  @override
  get concreteType => "$BreakLine";

  @override
  get correspondingTag => DomTag.breakLine;

  @override
  createConfiguration() => const WidgetConfiguration();

  @override
  isConfigurationChanged(oldConfiguration) => false;

  @override
  createRenderObject(context) => _BreakLineRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _BreakLineRenderObject extends RenderObject {
  const _BreakLineRenderObject(BuildContext context) : super(context);
}

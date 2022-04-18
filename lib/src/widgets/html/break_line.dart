import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The BreakLine widget (HTML's `br` tag).
///
class BreakLine extends Widget {
  const BreakLine({String? key}) : super(key: key);

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

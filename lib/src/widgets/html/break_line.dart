import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

class BreakLine extends Widget {
  BreakLine({String? id}) : super(id);

  @override
  DomTag get tag => DomTag.breakLine;

  @override
  String get type => "$BreakLine";

  @override
  createRenderObject(context) => BreakLineRenderObject(context);
}

class BreakLineRenderObject extends RenderObject {
  BreakLineRenderObject(BuildContext context) : super(context);

  @override
  void render(WidgetObject widgetObject) {}
}

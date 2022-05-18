import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';

/// The Blockquote widget (HTML's `blockquote` tag).
///
class Blockquote extends MarkUpTagWithGlobalProps {
  /// A URL for the source of the quotation may be given using the cite
  /// attribute.
  ///
  final String? cite;

  const Blockquote({
    Key? key,
    this.cite,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? id,
    String? title,
    String? style,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    String? onClick,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClickEventListener,
  }) : super(
          key: key,
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          onClick: onClick,
          innerText: innerText,
          child: child,
          children: children,
          onClickEventListener: onClickEventListener,
        );

  @nonVirtual
  @override
  get widgetType => '$Blockquote';

  @override
  get correspondingTag => DomTag.blockquote;

  @override
  createConfiguration() {
    return _BlockquoteConfiguration(
      cite: cite,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _BlockquoteConfiguration oldConfiguration) {
    return cite != oldConfiguration.cite ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _BlockquoteRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _BlockquoteConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? cite;

  const _BlockquoteConfiguration({
    this.cite,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _BlockquoteRenderObject extends MarkUpGlobalRenderObject {
  _BlockquoteRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _BlockquoteConfiguration configuration,
  }) {
    var elementDescription = super.render(
      configuration: configuration.globalConfiguration,
    );

    elementDescription?.attributes.addAll(
      _prepareAttributes(
        props: configuration,
        oldProps: null,
      ),
    );

    return elementDescription;
  }

  @override
  update({
    required updateType,
    required covariant _BlockquoteConfiguration oldConfiguration,
    required covariant _BlockquoteConfiguration newConfiguration,
  }) {
    var elementDescription = super.update(
      updateType: updateType,
      oldConfiguration: oldConfiguration.globalConfiguration,
      newConfiguration: newConfiguration.globalConfiguration,
    );

    elementDescription?.attributes.addAll(
      _prepareAttributes(
        props: newConfiguration,
        oldProps: oldConfiguration,
      ),
    );

    return elementDescription;
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required _BlockquoteConfiguration props,
  required _BlockquoteConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.cite) {
    attributes[Attributes.cite] = props.cite!;
  } else {
    if (null != oldProps?.cite) {
      attributes[Attributes.cite] = null;
    }
  }

  return attributes;
}

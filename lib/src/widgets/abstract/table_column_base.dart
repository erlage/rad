import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';

/// Abstract class for TableColumn and TableColumnGroup.
///
abstract class TableColumnBase extends MarkUpTagWithGlobalProps {
  /// This attribute contains a positive integer indicating the number of
  /// consecutive columns the TableColumn spans. If not present, its default
  /// value is 1.
  ///
  final int? span;

  const TableColumnBase({
    this.span,
    Key? key,
    String? id,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
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
          contenteditable: contenteditable,
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          dataAttributes: dataAttributes,
          onClick: onClick,
          innerText: innerText,
          child: child,
          children: children,
          onClickEventListener: onClickEventListener,
        );

  @override
  createConfiguration() {
    return _TableColumnBaseConfiguration(
      span: span,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(
    covariant _TableColumnBaseConfiguration oldConfiguration,
  ) {
    return span != oldConfiguration.span ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _TableColumnBaseRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _TableColumnBaseConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final int? span;

  const _TableColumnBaseConfiguration({
    this.span,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _TableColumnBaseRenderObject extends MarkUpGlobalRenderObject {
  _TableColumnBaseRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _TableColumnBaseConfiguration configuration,
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
    required covariant _TableColumnBaseConfiguration oldConfiguration,
    required covariant _TableColumnBaseConfiguration newConfiguration,
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
  required _TableColumnBaseConfiguration props,
  required _TableColumnBaseConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.span) {
    attributes[Attributes.span] = '${props.span}';
  } else {
    if (null != oldProps?.span) {
      attributes[Attributes.span] = null;
    }
  }

  return attributes;
}

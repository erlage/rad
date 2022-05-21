import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Base class for widgets that wants to register event listeners.
///
abstract class WidgetWithEventListeners extends Widget {
  final EventCallback? onInputEventListener;
  final EventCallback? onChangeEventListener;

  /// On form submit.
  ///
  /// Use event.preventDefault() to prevent default action.
  ///
  final EventCallback? onSubmitEventListener;
  final EventCallback? onClickEventListener;

  const WidgetWithEventListeners({
    Key? key,
    this.onInputEventListener,
    this.onChangeEventListener,
    this.onSubmitEventListener,
    this.onClickEventListener,
  }) : super(key: key);

  @override
  createConfiguration() {
    return EventListenersConfiguration(
      onInputEventListener: onInputEventListener,
      onChangeEventListener: onChangeEventListener,
      onSubmitEventListener: onSubmitEventListener,
      onClickEventListener: onClickEventListener,
    );
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    oldConfiguration as EventListenersConfiguration;

    return onInputEventListener.runtimeType !=
            oldConfiguration.onInputEventListener.runtimeType ||
        onChangeEventListener.runtimeType !=
            oldConfiguration.onChangeEventListener.runtimeType ||
        onSubmitEventListener.runtimeType !=
            oldConfiguration.onSubmitEventListener.runtimeType ||
        onClickEventListener.runtimeType !=
            oldConfiguration.onClickEventListener.runtimeType;
  }
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class EventListenersConfiguration extends WidgetConfiguration {
  final EventCallback? onInputEventListener;
  final EventCallback? onChangeEventListener;
  final EventCallback? onSubmitEventListener;
  final EventCallback? onClickEventListener;

  const EventListenersConfiguration({
    required this.onInputEventListener,
    required this.onChangeEventListener,
    required this.onSubmitEventListener,
    required this.onClickEventListener,
  });
}

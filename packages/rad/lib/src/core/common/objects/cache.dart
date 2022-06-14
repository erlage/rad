import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

// objects with cc prefix are cached objects, available globally. caching
// objects is probably the easiest way to introduce bugs so i'm trying to be
// more careful here and not going to cache all objects aggressively.
// once i've more cc objects here, i'll do some benchmarks

/// Immutable empty list of widgets.
///
const ccImmutableEmptyListOfWidgets = <Widget>[];

/// Immutable empty map of event listeners.
///
const ccImmutableEmptyMapOfEventListeners = <DomEventType, EventCallback>{};

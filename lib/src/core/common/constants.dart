import 'package:rad/src/core/common/objects/key.dart';

/// Class containing framework specific attributes and constants.
///
class Constants {
  // widget attributes

  static const attrRuntimeType = "wruntype";
  static const attrConcreteType = "wcontype";
  static const attrStateType = "wstatetype";

  // route specific

  static const attrRouteName = "wroutename";
  static const attrRoutePath = "wroutepath";

  // context specific

  static const contextTypeBigBang = "BigBang";
  static const contextKeyNotSet = Key("not-set");
  static const contextGenKeyPrefix = "_gen_";

  // errors

  static const coreError = "Framework has gone wild.";
  static const routerError = "Router has gone wild.";
}

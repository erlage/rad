/// Class containing framework specific attributes and constants.
///
class System {
  // widget attributes

  static const attrRuntimeType = "wruntype";
  static const attrConcreteType = "wcontype";
  static const attrStateType = "wstatetype";

  // route specific

  static const attrRouteName = "wroutename";
  static const attrRoutePath = "wroutepath";

  // context specific

  static const contextTypeBigBang = "BigBang";
  static const contextKeyNotSet = "not-set";
  static const contextGenKeyPrefix = "_gen";

  // errors

  static const coreError = "Framework has gone wild.";
  static const routerError = "Router has gone wild.";
}

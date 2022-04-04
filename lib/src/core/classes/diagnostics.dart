class Diagnostics {
  static var onException = presentException;
  static void exception(String message) => onException(Exception(message));

  static void presentException(Exception exception) => throw exception;
}

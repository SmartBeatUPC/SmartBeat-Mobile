import 'dart:developer' as developer;

class Logger {
  static void info(String message) {
    developer.log(message, name: 'LOG: INFO');
  }

  // Green text
  static void success(String message) {
    developer.log(message, name: 'LOG: SUCCESS');
  }

  // Yellow text
  static void warning(String message) {
    developer.log(message, name: 'LOG: WARNING');
  }

  // Red text
  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(message,
        error: error?.toString(),
        level: 1000,
        name: 'LOG: ERROR',
        stackTrace: stackTrace);
  }
}

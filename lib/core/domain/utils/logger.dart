import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._();
  AppLogger._() {
    _logger ??= Logger(
      printer: PrettyPrinter()
    );
  }
  static AppLogger get instance => _instance;

  static Logger? _logger;

  void info(dynamic message) {
    _logger!.i(message); //'Info message'
  }

  void debug(dynamic message) {
    _logger?.d(message); //Log message with 2 methods
  }

  void verbose(dynamic message) {
    _logger!.v(message);
  }

  void warning(dynamic message) {
    _logger!.w(message); //Just a warning!
  }

  void error(dynamic message) {
    _logger!.e(message); //Error! Something bad happened', 'Test Error'
  }
}

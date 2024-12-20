import 'package:flutter_base/core/services/logger_service.dart';
import 'package:logger/logger.dart';

class LoggerServiceImpl implements LoggerService {
  final _logger = Logger(
    printer: PrettyPrinter(lineLength: 1000),
  );

  @override
  void info(String message, {StackTrace? stackTrace}) {
    _logger.i(message, stackTrace: stackTrace);
  }

  @override
  void warn(String message, {StackTrace? stackTrace}) {
    _logger.w(message, stackTrace: stackTrace);
  }

  @override
  void error(String message, {StackTrace? stackTrace}) {
    _logger.e(message, stackTrace: stackTrace);
  }
}

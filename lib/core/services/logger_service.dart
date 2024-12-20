abstract class LoggerService {
  void info(String message, {StackTrace? stackTrace});

  void warn(String message, {StackTrace? stackTrace});

  void error(String message, {StackTrace? stackTrace});
}

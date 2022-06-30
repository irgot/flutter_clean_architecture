abstract class IPostErrors {
  final String message;
  final StackTrace? stackTrace;

  IPostErrors({required this.message, this.stackTrace});
}

class ArgumentsException extends IPostErrors {
  ArgumentsException({required super.message, super.stackTrace});
}

class DataSourceException extends IPostErrors {
  DataSourceException({required super.message, super.stackTrace});
}

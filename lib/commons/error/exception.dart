class SelectException implements Exception {}

class NotFoundException implements Exception {}

class ErrorException implements Exception {}

class ErrorDatabaseException implements Exception {}

class DartException implements Exception {
  DartException({required this.message});

  final String message;
}

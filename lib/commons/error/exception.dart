class SelectException implements Exception {}

class InsertException implements Exception {}

class DeleteException implements Exception {}

class NotFoundException implements Exception {}

class ErrorException implements Exception {}

class ErrorDatabaseException implements Exception {}

class GenericException implements Exception {
  GenericException({required this.message});

  final String message;
}

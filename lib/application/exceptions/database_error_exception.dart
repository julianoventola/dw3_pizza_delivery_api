class DatabaseErrorException implements Exception {
  String message;
  String exception;

  DatabaseErrorException({
    this.message,
    this.exception,
  });
}

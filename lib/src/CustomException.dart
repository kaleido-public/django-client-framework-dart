class CustomException implements Exception {
  String cause;
  CustomException(this.cause);
  String toString() => cause;
}
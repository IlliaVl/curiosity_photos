/// Thrown if during API requests failure occurs.
class CuriosityException implements Exception {
  /// Type of error.
  final CuriosityExceptionType errorType;

  /// The associated error message.
  final String message;

  /// Creates [CuriosityException].
  const CuriosityException(
    this.errorType, [
    this.message = 'An unknown exception occurred.',
  ]);
}

/// Types of [CuriosityException]s.
enum CuriosityExceptionType {
  /// If error occurs at parsing stage.
  parsing,

  /// If error occurs on API side.
  api,

  /// If error occurs at performing request stage.
  network,

  /// If error occurs by unknown reason.
  unknown
}

/// The abstract repository for authentication.
abstract class AuthRepositoryInterface {
  /// Creates new [AuthRepositoryInterface]
  AuthRepositoryInterface();

  /// Authenticate user for anonymous sign in.
  Future<void> anonymousAuth();
}

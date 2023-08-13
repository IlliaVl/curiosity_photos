import '../../domain/abstracts/repositories/auth_repository_interface.dart';
import '../providers/firebase_auth_provider.dart';

/// The Firebase repository for authentication.
class FirebaseAuthRepository extends AuthRepositoryInterface {
  final FirebaseAuthProvider _provider;

  /// Creates new [FirebaseAuthRepository]
  FirebaseAuthRepository({required FirebaseAuthProvider provider})
      : _provider = provider;

  /// Authenticate user for anonymous sign in.
  @override
  Future<void> anonymousAuth() => _provider.anonymousAuth();
}

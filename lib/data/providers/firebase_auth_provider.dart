import 'package:curiosity_photos/domain/exceptions/curiosity_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Firebase authentication provider
class FirebaseAuthProvider {
  /// Anonymous authentication with Firebase
  Future<void> anonymousAuth() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "network-request-failed":
          print("Network error.");
          throw const CuriosityException(
            CuriosityExceptionType.network,
          );
        default:
          print("Unknown error.");
          throw const CuriosityException(
            CuriosityExceptionType.unknown,
          );
      }
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

 
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e));
    } catch (e) {
      throw AuthException("An unknown error occurred during sign up.");
    }
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e));
    } catch (e) {
      throw AuthException("An unknown error occurred during sign in.");
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e));
    } catch (e) {
      throw AuthException("An unknown error occurred during password reset.");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw AuthException("Failed to sign out. Try again later.");
    }
  }

  User? get currentUser => _auth.currentUser;

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already registered. Try signing in.';
      case 'weak-password':
        return 'The password is too weak. Please use at least 6 characters.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled. Contact admin.';
      case 'too-many-requests':
        return 'Too many login attempts. Try again later.';
      case 'quota-exceeded':
        return 'Request quota exceeded. Try again shortly.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'timeout':
        return 'The request timed out. Please try again.';
      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      case 'invalid-credential':
        return 'Invalid credentials. Please try again.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method.';
      case 'credential-already-in-use':
        return 'This credential is already associated with another account.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Try again.';
      case 'missing-email':
        return 'Please enter your email.';
      case 'missing-password':
        return 'Please enter your password.';
      case 'missing-android-pkg-name':
      case 'missing-continue-uri':
      case 'missing-ios-bundle-id':
        return 'Configuration error. Please contact support.';
      case 'unverified-email':
        return 'Please verify your email address first.';
      default:
        return 'An error occurred: ${e.message ?? e.code}. Please try again.';
    }
  }
}

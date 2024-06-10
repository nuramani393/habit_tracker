class SignUpWithEmailAndPasswordFailure {
  final String message;

  SignUpWithEmailAndPasswordFailure(
      [this.message = "An unexpected error occurred. Please try again later."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
            'The email address is already in use by another account.');
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure(
            'The email address is invalid.');
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
            'Email/password accounts are not enabled.');
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure('The password is too weak.');
      case 'user-disabled':
        return SignUpWithEmailAndPasswordFailure(
            'The user account has been disabled.');
      default:
        return SignUpWithEmailAndPasswordFailure();
    }
  }
}

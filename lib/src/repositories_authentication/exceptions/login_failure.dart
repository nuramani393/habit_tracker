class LoginWithEmailAndPasswordFailure {
  final String message;

  LoginWithEmailAndPasswordFailure(
      [this.message = "An unexpected error occurred. Please try again later."]);

  factory LoginWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return LoginWithEmailAndPasswordFailure(
            'The email address is invalid.');
      case 'user-disabled':
        return LoginWithEmailAndPasswordFailure(
            'The user account has been disabled.');
      case 'user-not-found':
        return LoginWithEmailAndPasswordFailure(
            'There is no user record corresponding to this identifier. The user may have been deleted.');
      case 'wrong-password':
        return LoginWithEmailAndPasswordFailure(
            'The password is invalid or the user does not have a password.');
      default:
        return LoginWithEmailAndPasswordFailure();
    }
  }
}

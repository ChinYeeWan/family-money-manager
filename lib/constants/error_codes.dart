const signInErrorCodes = <String, String>{
  'user-not-found': 'User not Found',
  'wrong-password': 'Either eamil or password is wrong',
};

const signUpErrorCodes = <String, String>{
  'weak-password': 'The password is too weak',
  'email-already-in-use': 'An account already exists for this email',
};

const passwordResetErrorCodes = <String, String>{
  'auth/invalid-email': 'Enter a valid email',
  'auth/user-not-found': 'User not found',
};

class FirestoreApiException implements Exception {
  final String message;
  final String devDetails;
  final String prettyDetails;

  FirestoreApiException({
    this.message,
    this.devDetails,
    this.prettyDetails,
  });

  @override
  String toString() {
    return 'FirestoreApiException: $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}

class FormValidators {
  static Function name = (String name) {
    return name.length <= 6 ? 'Name too short.' : null;
  };
  static Function email = (String email) {
    if (!email.contains('@')) {
      return 'Email not Valid.';
    } else if (email.length <= 6) {
      return 'Email too short.';
    }
  };
  static Function password = (String password) {
    return password.length <= 8 ? 'Password too short.' : null;
  };
}

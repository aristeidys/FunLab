
class ReplaceUserNameAction {
  final String username;

  ReplaceUserNameAction(this.username);
}

typedef OnStateChanged = Function(dynamic);

String usernameReducer(String username, action) {
  if (action is ReplaceUserNameAction) {
    return action.username;
  } else {
    return username;
  }
}

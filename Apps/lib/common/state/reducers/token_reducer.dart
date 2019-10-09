class SetTokenAction {
  final String token;

  SetTokenAction(this.token);
}
class DeleteTokenAction {}

String tokenReducer(String token, action) {
  if (action is SetTokenAction) {
    return action.token;
  } else if (action is DeleteTokenAction) {
    return '';
  } else {
    return token;
  }
}

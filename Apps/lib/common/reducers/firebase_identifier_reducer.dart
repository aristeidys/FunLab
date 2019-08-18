
class ReplaceCurrentFcmIdentifierAction {
  final String id;

  ReplaceCurrentFcmIdentifierAction(this.id);
}

typedef OnStateChanged = Function(dynamic);

String fcmIdentifierReducer(String id, action) {
  if (action is ReplaceCurrentFcmIdentifierAction) {
    return action.id;
  } else {
    return id;
  }
}

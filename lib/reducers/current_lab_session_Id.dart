
class ReplaceCurrentLabIDAction {
  final int currentLabId;

  ReplaceCurrentLabIDAction(this.currentLabId);
}

typedef OnStateChanged = Function(dynamic);

int labSessionReducer(int currentLabId, action) {
  if (action is ReplaceCurrentLabIDAction) {
    return action.currentLabId;
  } else {
    return currentLabId;
  }
}

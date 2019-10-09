import 'package:funlab/common/models/session.dart';

class SetSessionAction {
  final Session session;

  SetSessionAction(this.session);
}
class DeleteSessionAction {}

Session sessionReducer(Session session, action) {
  if (action is SetSessionAction) {
    return action.session;
  } else if (action is DeleteSessionAction) {
    return null;
  } else {
    return session;
  }
}

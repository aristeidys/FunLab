import 'package:funlab/common/models/user.model.dart';

class SetUserAction {
  final User user;

  SetUserAction(this.user);
}
class DeleteUserAction {}

User userReducer(User user, action) {
  if (action is SetUserAction) {
    return action.user;
  } else if (action is DeleteUserAction) {
    return null;
  } else {
    return user;
  }
}

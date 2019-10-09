import 'package:funlab/common/models/message.model.dart';

class SetMessagesAction {
  final List<FirebaseMessage> messages;

  SetMessagesAction(this.messages);
}

class DeleteMessagesAction {}

List<FirebaseMessage> messagesReducer(List<FirebaseMessage> messages, action) {
  if (action is SetMessagesAction) {
    return action.messages;
  } else if (action is DeleteMessagesAction) {
    return null;
  } else {
    return messages;
  }
}

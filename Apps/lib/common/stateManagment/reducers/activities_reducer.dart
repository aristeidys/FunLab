import 'package:funlab/common/models/message.model.dart';

class ReplaceMessagesAction {
  final List<StudentMessage> messages;

  ReplaceMessagesAction(this.messages);
}

class ToggleMessagesStateAction {
  final StudentMessage messages;

  ToggleMessagesStateAction(this.messages);
}

typedef OnStateChanged = Function(dynamic);

List<StudentMessage> messagesReducer(List<StudentMessage> messages, action) {
  if (action is ReplaceMessagesAction) {
    return action.messages;
  } else {
    return messages;
  }
}

List<StudentMessage> toggleMessagesState(
    List<StudentMessage> items, ToggleMessagesStateAction action) {
  List<StudentMessage> itemsNew = items
      .map((messages) =>
          messages.title == action.messages.title ? action.messages : messages)
      .toList();
  return itemsNew;
}
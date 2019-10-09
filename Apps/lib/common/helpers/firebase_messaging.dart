import 'package:funlab/common/services/special/googleApi.service.dart';
import 'package:http/http.dart';

class FirebaseMessaging {
  Future<Response> sendMessage(int index) async {
    Response response = await Messaging().sendToToken(
        type: Messaging.messageTypeInstructorConfirm,
        title: 'Task confirmed',
        body: 'Your Instrucor Confirmed your task.',
        token: 'fsadfsdfdsfds',
        taskId: 43);
    return response;
  }
}

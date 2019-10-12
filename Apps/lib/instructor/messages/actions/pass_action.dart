import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/models/task_result.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/firebase.service.dart';
import 'package:funlab/common/services/task_result.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class PassWidget extends StatelessWidget {
  const PassWidget(
      {Key key,
      @required this.oldMessage,
      @required this.user,
      @required this.token,
      @required this.myContext,
      @required this.recipient,
      @required this.callback})
      : super(key: key);

  final User user;
  final FirebaseMessage oldMessage;
  final String token;
  final BuildContext myContext;
  final String recipient;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return IconSlideAction(
        caption: 'Pass',
        color: Colors.green,
        icon: Icons.assignment_turned_in,
        onTap: () async {
          TaskResult taskResult = TaskResult();
          taskResult.studentID = oldMessage.senderID;
          taskResult.taskID = oldMessage.taskID;
          taskResult.completed = true;
          TaskResultService().edit(taskResult).then((response) {
            if (response.statusCode == 200) {
              callback();
              CustomToaster().showToast(myContext, ToasterType.success,
                  'Successful sent pass message');
            } else {
              CustomToaster().showToast(myContext, ToasterType.failure,
                  'Failure sending pass message ${response.body}');
            }
          });

          FirebaseMessage message = FirebaseMessage(
              title: 'Pass Given',
              body:
                  'Instructor ${user.name} passed you on ${oldMessage.taskName}',
              taskID: oldMessage.taskID,
              taskName: oldMessage.taskName,
              senderID: user.id,
              senderToken: token,
              type: FirebaseMessage.pass,
              recipient: recipient);
          FirebaseService().send(message: message);
        });
  }
}

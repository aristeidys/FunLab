import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/models/task_result.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/firebase.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class HelpWidget extends StatelessWidget {
  const HelpWidget({
    Key key,
    @required this.taskResult,
    @required this.user,
    @required this.token,
    @required this.myContext,
    @required this.recipient,
  }) : super(key: key);

  final TaskResult taskResult;
  final User user;
  final String token;
  final BuildContext myContext;
  final String recipient;

  @override
  Widget build(BuildContext context) {
    return IconSlideAction(
        caption: 'Ask Help',
        color: Colors.yellow,
        icon: Icons.assignment_turned_in,
        onTap: () async {
          FirebaseMessage message = FirebaseMessage(
              title: 'Help needed',
              body: 'Student ${user.name} needs help with ${taskResult.taskName}',
              taskID: taskResult.taskID,
              taskName: taskResult.taskName,
              senderID: user.id,
              senderToken: token,
              type: FirebaseMessage.help,
              recipient: recipient);
          FirebaseService().send(message: message).then((response) {
            if (response.statusCode == 200) {
              CustomToaster().showToast(myContext, ToasterType.success,
                  'Successful sent help message');
            } else {
              CustomToaster().showToast(myContext, ToasterType.failure,
                  'Failure sending help message ${response.body}');
            }
          });
        });
  }
}

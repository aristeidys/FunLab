import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/firebase.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class HelpWidget extends StatelessWidget {
  const HelpWidget({
    Key key,
    @required this.task,
    @required this.user,
    @required this.token,
  }) : super(key: key);

  final Task task;
  final User user;
  final String token;

  @override
  Widget build(BuildContext context) {
    return IconSlideAction(
        caption: 'Ask Help',
        color: Colors.yellow,
        icon: Icons.assignment_turned_in,
        onTap: () async {
          FirebaseMessage message = FirebaseMessage(
              title: 'Help needed',
              body: 'Student ${user.name} needs help with ${task.name}',
              taskID: task.id,
              senderID: user.id,
              senderToken: token,
              type: FirebaseMessage.help);
          FirebaseService().send(message: message).then((response) {
            if (response.statusCode == 200) {
              CustomToaster().showToast(
                  context, ToasterType.success, 'Successful sent help request');
            } else {
              CustomToaster().showToast(context, ToasterType.failure,
                  'Failure sending help request ${response.body}');
            }
          });
        });
  }
}

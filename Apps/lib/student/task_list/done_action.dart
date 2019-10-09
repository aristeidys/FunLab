import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/firebase.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class DoneWidget extends StatelessWidget {
  const DoneWidget({
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
        caption: 'I am done',
        color: Colors.blue,
        icon: Icons.assignment_turned_in,
        onTap: () async {
          FirebaseMessage message = FirebaseMessage(
              title: 'A Student is finished',
              body: 'Student ${user.name} needs a check on task ${task.name}',
              taskID: task.id,
              senderID: user.id,
              senderToken: token,
              type: FirebaseMessage.help);
          FirebaseService().send(message: message).then((response) {
            if (response.statusCode == 200) {
              CustomToaster().showToast(
                  context, ToasterType.success, 'Successful sent done request');
            } else {
              CustomToaster().showToast(context, ToasterType.failure,
                  'Failure sending done request ${response.body}');
            }
          });
        });
  }
}

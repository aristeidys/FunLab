import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/firebase.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class PassWidget extends StatelessWidget {
  const PassWidget(
      {Key key,
      @required this.taskID,
      @required this.taskName,
      @required this.user,
      @required this.token,
      @required this.myContext,
      @required this.recipient,
      @required this.callback})
      : super(key: key);

  final int taskID;
  final String taskName;

  final User user;
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
          FirebaseMessage message = FirebaseMessage(
              title: 'Pass Given',
              body: 'Instructor ${user.name} passed you on $taskName',
              taskID: taskID,
              taskName: taskName,
              senderID: user.id,
              senderToken: token,
              type: FirebaseMessage.pass,
              recipient: recipient);
          FirebaseService().send(message: message).then((response) {
            if (response.statusCode == 200) {
              CustomToaster().showToast(myContext, ToasterType.success,
                  'Successful sent pass message');
              callback();
            } else {
              CustomToaster().showToast(myContext, ToasterType.failure,
                  'Failure sending pass message ${response.body}');
            }
          });
        });
  }
}

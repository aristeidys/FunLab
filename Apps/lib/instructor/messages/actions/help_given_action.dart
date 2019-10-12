import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/special/firebase.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class HelpGivenWidget extends StatelessWidget {
  const HelpGivenWidget({
    Key key,
    @required this.taskID,
    @required this.taskName,
    @required this.user,
    @required this.token,
    @required this.myContext,
    @required this.recipient,
    @required this.callback,
  }) : super(key: key);

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
        caption: 'Help Given',
        color: Colors.blue,
        icon: Icons.live_help,
        onTap: () async {
          FirebaseMessage message = FirebaseMessage(
              title: 'Help Given',
              body: 'Instructor ${user.name} helped you with $taskName',
              taskID: taskID,
              taskName: taskName,
              senderID: user.id,
              senderToken: token,
              type: FirebaseMessage.helpGiven,
              recipient: recipient);
          FirebaseService().send(message: message).then((response) {
            if (response.statusCode == 200) {
              CustomToaster().showToast(myContext, ToasterType.success,
                  'Successful sent help message');
              callback();
            } else {
              CustomToaster().showToast(myContext, ToasterType.failure,
                  'Failure sending help message ${response.body}');
            }
          });
        });
  }
}

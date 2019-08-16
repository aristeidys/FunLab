import 'package:flutter/material.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/services/lab_session.service.dart';
import 'package:funlab/common/widgets/form_with_button.dart';
import 'package:funlab/common/widgets/custom_future_list.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/student/pages/student_activity_list.dart';

class FindLabSessionForm extends StatefulWidget {
  @override
  _FindLabSessionFormState createState() => _FindLabSessionFormState();
}

class _FindLabSessionFormState extends State<FindLabSessionForm> {
  CustomFutureList<LabSession> list;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FormWithButton( 'Session Name', 'Join', (labSessionTitle) async {
        var result = await LabSessionService()
            .getLabSessionsWithTitle(context, labSessionTitle);

        if (result.length > 0 && result.last.draft == false) {
          print('index ${result.last.id}');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentActivityList(
                sessionIndex: result.last.id,
              )
            ),
          );
        } else {
          CustomToaster().showToast(context, ToasterType.failure,
              'No Session with name $labSessionTitle');
        }
      }),
    ]);
  }
}

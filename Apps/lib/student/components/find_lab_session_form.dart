import 'package:flutter/material.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/services/lab_session.service.dart';
import 'package:funlab/common/widgets/form_with_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class FindLabSessionForm extends StatefulWidget {
  @override
  _FindLabSessionFormState createState() => _FindLabSessionFormState();

  SearchSessionsCallback callback;

  FindLabSessionForm({@required this.callback});
}

class _FindLabSessionFormState extends State<FindLabSessionForm> {
  FutureBuilder<List<LabSession>> list;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FormWithButton( 'Session Name', 'Search', (labSessionTitle) async {
        var result = await LabSessionService()
            .getLabSessionsWithTitle(context, labSessionTitle);

        if (result.length > 0 && result.last.draft == false) {
          print('index ${result.last.id}');

          result.removeWhere((session) => session.draft == true);

          widget.callback(result);
        } else {
          CustomToaster().showToast(context, ToasterType.failure,
              'No Session with name $labSessionTitle');
        }
      }),
    ]);
  }
}

typedef void SearchSessionsCallback(List<LabSession> sessions);
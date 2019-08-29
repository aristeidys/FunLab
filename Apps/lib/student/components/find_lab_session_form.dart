import 'package:flutter/material.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/services/lab_session.service.dart';
import 'package:funlab/common/widgets/form_with_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

typedef void SearchSessionCallback(LabSession labSession);

class FindLabSessionForm extends StatelessWidget {

  final SearchSessionCallback buttonCallback;
  FindLabSessionForm({@required this.buttonCallback});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FormWithButton( 'Session Name', 'Enroll', (labSessionTitle) async {
        var result = await LabSessionService().getLabSessionsWithTitle(context, labSessionTitle);

        if (result.length > 0 && result.last.draft == false) {
          print('index ${result.last.id}');

          result.removeWhere((session) => session.draft == true);

          buttonCallback(result.first);
        } else {
          CustomToaster().showToast(context, ToasterType.failure,
              'No Session with name $labSessionTitle');
        }
      }),
    ]);
  }
}
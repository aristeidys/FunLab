import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/reducers/current_lab_session_Id.dart';
import 'package:funlab/common/services/lab_session.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/edit_button.dart';
import 'package:funlab/instructor/components/activity_form.dart';
import 'package:funlab/instructor/components/lab_session_form.dart';

class InstructorForms extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LabSession>(
        converter: (store) => store.state.currentLabSession,
        builder: (context, labSession) {
          return labSession == null
              ? LabSessionForm()
              : Column(children: <Widget>[
                  ActivityForm(),
                  EditLabSessionButton(
                    labSession: labSession,
                  )
                ]);
        });
  }
}

class EditLabSessionButton extends StatelessWidget {
  const EditLabSessionButton({
    Key key,
    this.labSession,
  }) : super(key: key);

  final labSession;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(converter: (store) {
      return (labSession) =>
          store.dispatch(ReplaceCurrentLabAction(labSession));
    }, builder: (context, callback) {
      return EditButton('Publish Lab Session', () {
        LabSession newSession =
            LabSession(title: labSession.title, id: labSession.id, draft: false, finished: labSession.finished);

        HttpService().putRequest(newSession, newSession.id, (success, id) {
          if (success) {
            callback(newSession);
            CustomToaster().showToast(
                context, ToasterType.success, 'Lab Session is published');
          } else {
            CustomToaster().showToast(
                context, ToasterType.failure, 'Lab Session publish failed');
          }
        });
      });
    });
  }
}

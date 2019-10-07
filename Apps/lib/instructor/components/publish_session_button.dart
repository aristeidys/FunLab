import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/services/special/lab_session.service.dart';
import 'package:funlab/common/stateManagment/app_state.dart';
import 'package:funlab/common/stateManagment/reducers/activities_reducer.dart';
import 'package:funlab/common/stateManagment/reducers/current_lab_session_Id.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/instructor/pages/instructor_dashboard.dart';

class PublishSessionButton extends StatelessWidget {
  const PublishSessionButton({
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
        LabSession newSession = LabSession(
            title: labSession.title,
            id: labSession.id,
            draft: false,
            finished: labSession.finished);

        LabSessionService().putRequest(newSession, newSession.id,
            (success, id, errorMessage) {
          if (success) {
            callback(newSession);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SessionDashboardPage()),
            );
          } else {
            CustomToaster().showToast(
                context, ToasterType.failure, 'Lab Session publish failed');
          }
        });
      });
    });
  }
}

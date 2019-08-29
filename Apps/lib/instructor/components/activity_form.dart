import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/services/activity.service.dart';
import 'package:funlab/common/widgets/form_with_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class ActivityForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LabSession>(
        converter: (store) => store.state.currentLabSession,
        builder: (context, labSession) {
          return FormWithButton('Enter Activity Name', 'Add Activity', (labSessionTitle) {
                  Activity activity = Activity(title: labSessionTitle, labSessionId: labSession.id);
                  ActivityService().postRequest(activity, (success, id, errorMessage) {
                    if (success) {
                      CustomToaster().showToast(context, ToasterType.success,
                          'Activity Created Successfully');
                    } else {
                      CustomToaster().showToast(context, ToasterType.failure,
                          'Failure Creating Activity');
                    }
                  });
                });
        });
  }
}
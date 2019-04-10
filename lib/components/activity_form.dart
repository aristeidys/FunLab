import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/models/assignment.model.dart';
import 'package:funlab/reducers/app_state.dart';
import 'package:funlab/services/activity.service.dart';
import 'package:funlab/widgets/custom_form.dart';
import 'package:funlab/widgets/custom_texts.dart';
import 'package:funlab/widgets/custom_toaster.dart';

class ActivityForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
        converter: (store) => store.state.currentLabId,
        builder: (context, id) {
          return id < 0
              ? Container(
                  child: new QuatedText('Create a Session First.'),
                )
              : MyCustomForm((labSessionTitle) {
                  Activity activity = Activity(title: labSessionTitle, id: id);
                  ActivityService().createActivity(activity, (success, id) {
                    if (success) {
                      CustomToaster().showToast(context, ToasterType.success,
                          'Activity Created Successfully');
                    } else {
                      CustomToaster().showToast(context, ToasterType.failure,
                          'Failure Creating Activity');
                    }
                  });
                }, 'Enter Activity Name');
        });
  }
}
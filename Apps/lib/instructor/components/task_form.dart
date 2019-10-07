import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/services/special/task.service.dart';
import 'package:funlab/common/stateManagment/app_state.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class TaskForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LabSession>(
        converter: (store) => store.state.currentLabSession,
        builder: (context, labSession) {
          return FormWithButton('Enter Task Name', 'Add Task', (labSessionTitle) {
                  Task task = Task(title: labSessionTitle, labSessionId: labSession.id);
                  TaskService().postRequest(task, (success, id, errorMessage) {
                    if (success) {
                      CustomToaster().showToast(context, ToasterType.success,
                          'Task Created Successfully');
                    } else {
                      CustomToaster().showToast(context, ToasterType.failure,
                          'Failure Creating Task');
                    }
                  });
                });
        });
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/services/task.service.dart';
import 'package:funlab/common/stateManagment/state.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/instructor/session_create/task_create_form.dart';

class TaskFormController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, Session>(
        converter: (store) => store.state.session,
        builder: (context, session) {
          return TaskCreateForm((name, difficulty) {
            Task task =
                Task(name: name, sessionID: session.id, difficulty: difficulty);
            TaskService().create(task).then((response) {
              if (response.data == null) {
                CustomToaster().showToast(
                    context, ToasterType.failure, 'Failure Creating Task ${response.error}');
              } else {
                CustomToaster().showToast(
                    context, ToasterType.success, 'Task ${task.name} Created Successfully');
              }
            });
          });
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/stateManagment/appInstructorState.dart';
import 'package:funlab/common/stateManagment/reducers/session_reducer.dart';
import 'package:funlab/common/stateManagment/store.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/instructor/session_create/task_form_controller.dart';

class TasksCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, Session>(
        converter: (store) => store.state.session,
        builder: (context, session) {
          return StoreConnector<AppInstructorState, OnStateChanged>(
              converter: (store) {
            return (session) => store.dispatch(SetSessionAction(session));
          }, builder: (context, callback) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Styles.instructorColor,
                  title: Text('Create Session ${session.title}'),
                ),
                body: TaskFormController());
          });
        });
  }
}

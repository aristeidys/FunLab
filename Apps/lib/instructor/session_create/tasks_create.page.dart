import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/services/session.service.dart';
import 'package:funlab/common/stateManagment/state.dart';
import 'package:funlab/common/stateManagment/reducers/session_reducer.dart';
import 'package:funlab/common/stateManagment/store.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/instructor/session_create/task_form_controller.dart';

class TasksCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Session>(
        converter: (store) => store.state.session,
        builder: (context, session) {
          return StoreConnector<AppState, OnStateChanged>(
              converter: (store) {
            return (session) => store.dispatch(SetSessionAction(session));
          }, builder: (context, callback) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Styles.instructorColor,
                  title: Text('Create Session ${session.title}'),
                ),
                body: Column(
                  children: <Widget>[
                    TaskFormController(),
                    Container(
                      height: 15,
                    ),
                    Text('Click here to make the Session available.'),
                    ActivateSeasonButton()
                  ],
                ));
          });
        });
  }
}

class ActivateSeasonButton extends StatelessWidget {
  
  ActivateSeasonButton();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Session>(
        converter: (store) => store.state.session,
        builder: (context, session) {
          return StoreConnector<AppState, OnStateChanged>(
        converter: (store) {
      return (session) => store.dispatch(SetSessionAction(session));
    }, builder: (context, callback) {
      return EditButton('Activate Session', () {
        Session localSession = session;
        localSession.status = 'active';
        SessionService().put(localSession).then((response) {
          if (response.data == null) {
            CustomToaster().showToast(context, ToasterType.failure,
                'Failure Changing Status ${response.error}');
          } else {
            callback(response.data);
            CustomToaster().showToast(context, ToasterType.success,
                'Task status updated Successfully');
          }
        });
      });
    });
    });
  }
}

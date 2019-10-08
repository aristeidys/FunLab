import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/stateManagment/app_state.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';

class SessionCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LabSession>(
        converter: (store) => store.state.currentLabSession,
        builder: (context, labSession) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Styles.instructorColor,
                title: Text('Create Session'),
              ),
              body: FormWithButton('Enter Session Name', 'Create Draft Session',
                  (labSessionTitle) {}));
        });
  }
}

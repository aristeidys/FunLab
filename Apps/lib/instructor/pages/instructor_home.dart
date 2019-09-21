import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/find_lab_session_form.dart';
import 'package:funlab/instructor/components/publish_session_button.dart';
import 'package:funlab/instructor/components/lab_session_form.dart';
import 'package:funlab/instructor/components/task_form.dart';

import 'instructor_dashboard.dart';

class InstructorHomePage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Find a Session'),
        ),
        body: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[InstructorForms()]));
  }
}

class InstructorForms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LabSession>(
        converter: (store) => store.state.currentLabSession,
        builder: (context, labSession) {
          return Column(children: <Widget>[
            labSession == null
                ? LabSessionForm()
                : Column(children: <Widget>[
                    TaskForm(),
                    PublishSessionButton(
                      labSession: labSession,
                    )
                  ]),
            FindLabSessionForm(buttonCallback: (LabSession session) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SessionDashboardPage()),
              );
            }),
          ]);
        });
  }
}

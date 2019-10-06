import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/find_lab_session_form.dart';
import 'package:funlab/instructor/pages/new_classroom.page.dart';
import 'instructor_dashboard.dart';
import 'instructor_new_session.dart';

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
            FindLabSessionForm(buttonCallback: (LabSession session) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SessionDashboardPage()),
              );
            }),
            CreateButton(
                'Create new Session',
                () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SessionCreatePage()),
                    )),
            CreateButton(
                'Create new Classroom',
                () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassroomCreatePage()),
                    ))
          ]);
        });
  }
}

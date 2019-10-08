import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/stateManagment/state.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/instructor/enrollments/manage_enrollments.page.dart';
import 'package:funlab/instructor/session_create/session_create.page.dart';
import 'package:funlab/instructor/session_manage/sessions.page.dart';

class ClassroomDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Classroom>(
        converter: (store) => store.state.classroom,
        builder: (context, classroom) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Styles.instructorColor,
                title: Text('Inside Classroom ${classroom.name}'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 10,
                    ),
                    EditButton(
                        'See all Sessions',
                        () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SessionsPage()),
                            )),
                    EditButton(
                        'Manage Enrollments',
                        () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ManageEnrollmentsPage()),
                            )),
                    EditButton(
                        'Create new Session',
                        () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SessionCreatePage()),
                            )),
                  ],
                ),
              ));
        });
  }
}

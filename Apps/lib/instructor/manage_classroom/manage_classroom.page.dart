import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/stateManagment/appInstructorState.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';

import 'manage_enrollments.page.dart';

class ManageClassroomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Manage Classroom'),
        ),
        body: OptionsWidget());
  }
}

class OptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, Classroom>(
        converter: (store) => store.state.classroom,
        builder: (context, user) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('hi ${user.name}, what would you like to do?'),
                Container(
                  height: 10,
                ),
                EditButton(
                    'Manage Enrollments',
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageEnrollmentsPage()),
                        )),
              ],
            ),
          );
        });
  }
}

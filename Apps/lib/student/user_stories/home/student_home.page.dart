import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/stateManagment/appInstructorState.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/instructor/join_classroom/join_classroom.page.dart';
import 'package:funlab/student/components/drawer.dart';
import 'package:funlab/student/user_stories/classroom_enroll/classroom_enroll.page.dart';

class StudentHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.studentMainColor,
        title: Text('Student Home'),
      ),
      body: OptionsWidget(),
      drawer: StudentDrawer(),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, User>(
        converter: (store) => store.state.user,
        builder: (context, user) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('hi ${user.name}, what would you like to do?'),
                Container(
                  height: 10,
                ),
                CreateButton(
                    'Enroll in a Classroom',
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassroomEnrollPage()),
                        )),
                Container(
                  height: 10,
                ),
                EditButton(
                    'Join in a Classroom',
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassroomJoinPage()),
                        )),
              ],
            ),
          );
        });
  }
}

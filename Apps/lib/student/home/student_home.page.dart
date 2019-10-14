import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/helpers/firebase_widget.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/state/state.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/student/classroom_enroll/classroom_enroll.page.dart';
import 'package:funlab/student/classroom_join/classroom_join.page.dart';
import 'package:funlab/common/services/special/firebase.service.dart';

class StudentHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.studentMainColor,
        title: Text('Student Home'),
      ),
      body: OptionsWidget(),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
        converter: (store) => store.state.user,
        builder: (context, user) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FireBaseWidget(),
                Text('hi ${user.name}, what would you like to do?'),
                Container(
                  height: 10,
                ),
                CreateButton(
                    'Join a Classroom',
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentClassroomJoinPage()),
                        )),
                Container(
                  height: 10,
                ),
                EditButton(
                    'Enroll in a Classroom',
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassroomEnrollPage()),
                        )),
              ],
            ),
          );
        });
  }
}

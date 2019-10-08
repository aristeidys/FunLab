import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/stateManagment/appInstructorState.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/instructor/classroom_join/classroom_join.page.dart';
import 'package:funlab/instructor/components/drawer.dart';
import 'package:funlab/instructor/pages/new_classroom.page.dart';
import 'package:funlab/instructor/session_create/session_create.page.dart';

class InstructorHomePage extends StatelessWidget {
  InstructorHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.instructorColor,
        title: Text('Instructor Home'),
      ),
      body: OptionsWidget(),
      drawer: InstructorDrawer(),
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
                    'Create new Classroom',
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassroomCreatePage()),
                        )),
                EditButton(
                    'Join a Classroom',
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassroomJoinPage()),
                        )),
                CreateButton(
                    'Create new Session',
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SessionCreatePage()),
                        )),
              ],
            ),
          );
        });
  }
}

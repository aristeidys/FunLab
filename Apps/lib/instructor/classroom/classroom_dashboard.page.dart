import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/helpers/firebase_widget.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/state/state.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/instructor/enrollments/active_enrollments.page.dart';
import 'package:funlab/instructor/enrollments/pending_enrollments.page.dart';
import 'package:funlab/instructor/messages/message_list.page.dart';
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
                    FireBaseWidget(channel: classroom.name,),
                    Container(
                      height: 10,
                    ),
                    EditButton(
                        'See all Messages',
                        () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MessageListPage()),
                            )),
                    EditButton(
                        'See all Sessions',
                        () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SessionsPage()),
                            )),
                    EditButton(
                        'Create new Session',
                        () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SessionCreatePage()),
                            )),
                    EditButton(
                        'Active Enrollments',
                        () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ActiveEnrollmentsPage()),
                            )),
                    EditButton(
                        'Pending Enrollments',
                        () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PendingEnrollmentsPage()),
                            )),
                  ],
                ),
              ));
        });
  }
}

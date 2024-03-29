import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/classroom.service.dart';
import 'package:funlab/common/state/state.dart';
import 'package:funlab/common/state/reducers/classroom_reducer.dart';
import 'package:funlab/common/state/store.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';
import 'package:funlab/student/classroom_join/session_list.page.dart';

class StudentClassroomJoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.studentMainColor,
          title: Text('Join a Classroom'),
        ),
        body: new BodyWidget());
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(converter: (store) {
      return (session) => store.dispatch(SetClassroomAction(session));
    }, builder: (context, callback) {
      return StoreConnector<AppState, User>(
          converter: (store) => store.state.user,
          builder: (context, student) {
            return FormWithButton('Enter Classroom Name', 'Join Classroom',
                (name) {
              ClassroomService()
                  .getByNameAndStudentID(name, student.id)
                  .then((response) {
                if (response.data != null) {
                  callback(response.data);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SessionListPage()),
                  );
                } else {
                  CustomToaster().showToast(context, ToasterType.failure,
                      'Error Entering Classroom. ${response.error}');
                }
              });
            });
          });
    });
  }
}

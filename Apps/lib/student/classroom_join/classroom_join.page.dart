import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/services/classroom.service.dart';
import 'package:funlab/common/stateManagment/state.dart';
import 'package:funlab/common/stateManagment/reducers/classroom_reducer.dart';
import 'package:funlab/common/stateManagment/store.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';
import 'package:funlab/student/classroom_join/session_list.page.dart';

class ClassroomJoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(
        converter: (store) {
      return (session) => store.dispatch(SetClassroomAction(session));
    }, builder: (context, callback) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Styles.studentMainColor,
            title: Text('Join a Classroom'),
          ),
          body:
              FormWithButton('Enter Classroom Name', 'Join Classroom', (name) {
            ClassroomService().getByName(name).then((response) {
              if (response.data != null) {
                callback(response.data);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionListPage()),
                );
              } else {
                CustomToaster().showToast(context, ToasterType.failure,
                    'Failure joining Classroom. ${response.error}');
              }
            });
          }));
    });
  }
}

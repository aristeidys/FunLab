import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/services/classroom.service.dart';
import 'package:funlab/common/state/state.dart';
import 'package:funlab/common/state/reducers/classroom_reducer.dart';
import 'package:funlab/common/state/store.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';

import 'classroom_dashboard.page.dart';

class ClassroomJoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(
        converter: (store) {
      return (classroom) => store.dispatch(SetClassroomAction(classroom));
    }, builder: (context, callback) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Join a Classroom'),
        ),
        body: FormWithButton('Enter Classroom Name', 'Join Classroom', (name) {
          ClassroomService().getByName(name).then((response) {
            if (response.data != null) {
              callback(response.data);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClassroomDashboardPage()),
              );
            } else {
              CustomToaster().showToast(context, ToasterType.failure,
                  'Failure joining Classroom. ${response.error}');
            }
          });
        }),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/services/session.service.dart';
import 'package:funlab/common/stateManagment/appInstructorState.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/instructor/session_create/session_create_form.dart';

class SessionCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppInstructorState, Classroom>(
        converter: (store) => store.state.classroom,
        builder: (context, classroom) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Styles.instructorColor,
                title: Text('Create Session'),
              ),
              body: SessionCreateForm((title, description) {
                Session session = Session(
                    description: description,
                    title: title,
                    classroomID: classroom.id);
                SessionService().create(session).then((response) {
                  if (response.data != null) {
                    CustomToaster().showToast(context, ToasterType.success,
                        'Successfully created ${session.title}');
                  } else {
                    CustomToaster().showToast(context, ToasterType.failure,
                        'Failed to create session ${response.error}');
                  }
                });
              }));
        });
  }
}

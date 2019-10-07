import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/stateManagment/reducers/classroom_reducer.dart';

import '../appInstructorState.dart';
import '../store.dart';

class SetClassroomState extends StatelessWidget {
  final Classroom classroom;

  SetClassroomState(this.classroom);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppInstructorState, OnStateChanged>(converter: (store) {
        return (classroom) => store.dispatch(SetClassroomAction(classroom));
      }, builder: (context, callback) {
        callback(classroom);
        return Container();
      });
}

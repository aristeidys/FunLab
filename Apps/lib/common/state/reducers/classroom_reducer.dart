import 'package:funlab/common/models/classroom.model.dart';

class SetClassroomAction {
  final Classroom classroom;

  SetClassroomAction(this.classroom);
}
class DeleteClassroomAction {}

Classroom classroomReducer(Classroom classroom, action) {
  if (action is SetClassroomAction) {
    return action.classroom;
  } else if (action is DeleteClassroomAction) {
    return null;
  } else {
    return classroom;
  }
}

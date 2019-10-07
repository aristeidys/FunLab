import '../appInstructorState.dart';
import 'classroom_reducer.dart';
import 'user_reducer.dart';

AppInstructorState appInstructorReducer(AppInstructorState state, action) {
  return AppInstructorState(
    user: userReducer(state.user, action),
    classroom: classroomReducer(state.classroom, action),
  );
}

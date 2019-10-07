import '../appInstructorState.dart';
import '../appStudentState.dart';
import 'user_reducer.dart';

AppInstructorState appInstructorReducer(AppInstructorState state, action) {
  return AppInstructorState(
    user: userReducer(state.user, action),
  );
}

AppStudentState appStudentReducer(AppStudentState state, action) {
  return AppStudentState(
    user: userReducer(state.user, action),
  );
}

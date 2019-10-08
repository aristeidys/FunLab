import 'package:funlab/common/stateManagment/reducers/classroom_reducer.dart';
import 'package:funlab/common/stateManagment/reducers/session_reducer.dart';
import 'package:funlab/common/stateManagment/reducers/user_reducer.dart';
import 'package:funlab/common/stateManagment/state.dart';

AppState appInstructorReducer(AppState state, action) {
  return AppState(
    user: userReducer(state.user, action),
    classroom: classroomReducer(state.classroom, action),
    session: sessionReducer(state.session, action),
  );
}
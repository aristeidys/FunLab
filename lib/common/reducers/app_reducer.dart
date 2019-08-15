import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/reducers/counter_reducer.dart';
import 'package:funlab/common/reducers/current_lab_session_Id.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      totalQuestions: 1,
      questionIndex: questionReducer(state.questionIndex, action),
      currentLabSession: labSessionReducer(state.currentLabSession, action),
  );
}
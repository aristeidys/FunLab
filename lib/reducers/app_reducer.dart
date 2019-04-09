import 'package:funlab/reducers/app_state.dart';
import 'package:funlab/reducers/counter_reducer.dart';
import 'package:funlab/reducers/current_lab_session_Id.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      totalQuestions: 1,
      questionIndex: questionReducer(state.questionIndex, action),
      currentLabId: labSessionReducer(state.currentLabId, action),
  );
}
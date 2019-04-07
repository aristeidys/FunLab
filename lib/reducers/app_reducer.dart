import 'package:funlab/models/app_state.dart';
import 'package:funlab/reducers/counter_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      totalQuestions: 1,
      questionIndex: questionReducer(state.questionIndex, action),
  );
}
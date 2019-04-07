import 'package:funlab/actions/counter_actions.dart';

int questionReducer(int questionIndex, action) {
  if (action is NextQuestionAction) {
    questionIndex++;
    return questionIndex;
	} else if (action is PreviousQuestionAction) {
		questionIndex--;
		return questionIndex;
  } else {
    return questionIndex;
  }
}
// models/app_state.dart
class AppState {
  final int questionIndex;
  final int totalQuestions;

  AppState({this.questionIndex = 1, this.totalQuestions = 1});

	AppState copyWith({int questionIndex, bool totalQuestions}) {
		return AppState(
			questionIndex: questionIndex ?? this.questionIndex,
			totalQuestions: totalQuestions ?? this.totalQuestions
		);
	}

	@override
	String toString() {
		return 'AppState{current Question: $questionIndex, of total: $totalQuestions}';
	}
}
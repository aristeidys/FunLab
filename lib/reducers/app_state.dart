
class AppState {
  final int questionIndex;
  final int totalQuestions;
  final int currentLabId;
  AppState(
      {this.questionIndex = 1, this.totalQuestions = 1, this.currentLabId = -1});

  AppState copyWith(
      {int questionIndex, bool totalQuestions, int currentLabId}) {
    return AppState(
        questionIndex: questionIndex ?? this.questionIndex,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        currentLabId: currentLabId ?? this.currentLabId);
  }

  @override
  String toString() {
    return 'AppState{current Question: $questionIndex, of total: $totalQuestions}';
  }
}

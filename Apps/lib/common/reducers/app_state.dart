import 'package:funlab/common/models/lab_session.model.dart';

class AppState {
  final int questionIndex;
  final int totalQuestions;
  final LabSession currentLabSession;
  final String username;

  AppState(
      {this.questionIndex = 1,
      this.totalQuestions = 1,
      this.currentLabSession,
      this.username});

  AppState copyWith(
      {int questionIndex, bool totalQuestions, LabSession currentLabSession, String username}) {
    return AppState(
        questionIndex: questionIndex ?? this.questionIndex,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        currentLabSession: currentLabSession ?? this.currentLabSession,
        username: username ?? this.username);
  }

  @override
  String toString() {
    return 'AppState Changes';
  }
}

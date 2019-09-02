import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/models/message.model.dart';

class AppState {
  final int questionIndex;
  final int totalQuestions;
  final LabSession currentLabSession;
  final String username;
  final List<StudentMessage> currentMessages;

  AppState(
      {this.questionIndex = 1,
      this.totalQuestions = 1,
      this.currentLabSession,
      this.username,
      this.currentMessages});

  AppState copyWith(
      {int questionIndex, bool totalQuestions, LabSession currentLabSession, String username, List<StudentMessage> currentMessages}) {
    return AppState(
        questionIndex: questionIndex ?? this.questionIndex,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        currentLabSession: currentLabSession ?? this.currentLabSession,
        username: username ?? this.username,
        currentMessages: currentMessages ?? this.currentMessages);
  }

  @override
  String toString() {
    return 'AppState Changes';
  }
}

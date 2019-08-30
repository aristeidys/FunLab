import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/models/lab_session.model.dart';

class AppState {
  final int questionIndex;
  final int totalQuestions;
  final LabSession currentLabSession;
  final String username;
  final List<Activity> currentActivities;

  AppState(
      {this.questionIndex = 1,
      this.totalQuestions = 1,
      this.currentLabSession,
      this.username,
      this.currentActivities});

  AppState copyWith(
      {int questionIndex, bool totalQuestions, LabSession currentLabSession, String username, List<Activity> currentActivities}) {
    return AppState(
        questionIndex: questionIndex ?? this.questionIndex,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        currentLabSession: currentLabSession ?? this.currentLabSession,
        username: username ?? this.username,
        currentActivities: currentActivities ?? this.currentActivities);
  }

  @override
  String toString() {
    return 'AppState Changes';
  }
}

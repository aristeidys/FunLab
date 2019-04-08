// models/app_state.dart
import 'package:funlab/models/dataModel/lab_session.model.dart';

class AppState {
  final int questionIndex;
  final int totalQuestions;
  final LabSession labSession = LabSession();

  AppState(
      {this.questionIndex = 1, this.totalQuestions = 1, LabSession labSession});

  AppState copyWith(
      {int questionIndex, bool totalQuestions, LabSession labSession}) {
    return AppState(
        questionIndex: questionIndex ?? this.questionIndex,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        labSession: labSession ?? this.labSession);
  }

  @override
  String toString() {
    return 'AppState{current Question: $questionIndex, of total: $totalQuestions session $labSession}';
  }
}

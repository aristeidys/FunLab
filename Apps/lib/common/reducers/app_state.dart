
import 'package:funlab/common/models/lab_session.model.dart';

class AppState {
  final int questionIndex;
  final int totalQuestions;
  final LabSession currentLabSession;
  AppState(
      {this.questionIndex = 1, this.totalQuestions = 1, this.currentLabSession});

  AppState copyWith(
      {int questionIndex, bool totalQuestions, LabSession currentLabSession}) {
    return AppState(
        questionIndex: questionIndex ?? this.questionIndex,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        currentLabSession: currentLabSession ?? this.currentLabSession);
  }

  @override
  String toString() {
    return 'AppState{current LabSession ID ${currentLabSession.toString()}';
  }
}

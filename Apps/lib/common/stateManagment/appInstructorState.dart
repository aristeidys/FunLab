import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/user.model.dart';

class AppInstructorState {
  final User user;
  final Classroom classroom;

  AppInstructorState({this.user, this.classroom});

  AppInstructorState copyWith({User user, Classroom classroom}) {
    return AppInstructorState(
        user: user ?? this.user, classroom: classroom ?? this.classroom);
  }
}

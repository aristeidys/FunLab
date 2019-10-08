import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/models/user.model.dart';

class AppInstructorState {
  final User user;
  final Classroom classroom;
  final Session session;

  AppInstructorState({this.user, this.classroom, this.session});

  AppInstructorState copyWith(
      {User user, Classroom classroom, Session session}) {
    return AppInstructorState(
        user: user ?? this.user,
        classroom: classroom ?? this.classroom,
        session: session ?? this.session);
  }
}

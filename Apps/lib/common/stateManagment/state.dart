import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/models/user.model.dart';

class AppState {
  final User user;
  final Classroom classroom;
  final Session session;

  AppState({this.user, this.classroom, this.session});

  AppState copyWith(
      {User user, Classroom classroom, Session session}) {
    return AppState(
        user: user ?? this.user,
        classroom: classroom ?? this.classroom,
        session: session ?? this.session);
  }
}

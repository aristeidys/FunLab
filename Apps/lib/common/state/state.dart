import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/models/user.model.dart';

class AppState {
  final User user;
  final Classroom classroom;
  final Session session;
  final List<FirebaseMessage> messages;
  final String token;

  AppState(
      {this.user, this.classroom, this.session, this.messages, this.token});

  factory AppState.initial() {
    return AppState(
        user: User(),
        classroom: Classroom(),
        session: Session(),
        messages: List<FirebaseMessage>(),
        token: '');
  }
  AppState copyWith(
      {User user,
      Classroom classroom,
      Session session,
      List<FirebaseMessage> messages,
      String token}) {
    return AppState(
        user: user ?? this.user,
        classroom: classroom ?? this.classroom,
        session: session ?? this.session,
        messages: messages ?? this.messages,
        token: token ?? this.token);
  }
}

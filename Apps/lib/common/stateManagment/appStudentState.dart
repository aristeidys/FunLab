import 'package:funlab/common/models/user.model.dart';

class AppStudentState {
  final User user;

  AppStudentState({this.user});

  AppStudentState copyWith({User user}) {
    return AppStudentState(user: user ?? this.user);
  }
}

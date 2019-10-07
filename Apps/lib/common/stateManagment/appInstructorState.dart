
import 'package:funlab/common/models/user.model.dart';

class AppInstructorState {
  final User user;

  AppInstructorState({this.user});

  AppInstructorState copyWith({User user}) {
    return AppInstructorState(
      user: user ?? this.user
    );
  }
}

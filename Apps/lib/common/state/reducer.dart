import 'package:funlab/common/state/reducers/classroom_reducer.dart';
import 'package:funlab/common/state/reducers/messages_reducer.dart';
import 'package:funlab/common/state/reducers/session_reducer.dart';
import 'package:funlab/common/state/reducers/token_reducer.dart';
import 'package:funlab/common/state/reducers/user_reducer.dart';
import 'package:funlab/common/state/state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    user: userReducer(state.user, action),
    classroom: classroomReducer(state.classroom, action),
    session: sessionReducer(state.session, action),
    messages: messagesReducer(state.messages, action),
    token: tokenReducer(state.token, action),
  );
}


import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'state.dart';
import 'reducers/app_reducer.dart';

Store<AppInstructorState> createInstructorStore() {
  return Store(
    appInstructorReducer,
    initialState: AppInstructorState(),
    middleware: [
      LoggingMiddleware.printer(),
    ],
  );
}

typedef OnStateChanged = Function(dynamic);

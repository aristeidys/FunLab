
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import '../appInstructorState.dart';
import 'app_reducer.dart';

Store<AppInstructorState> createInstructorStore() {
  return Store(
    appInstructorReducer,
    initialState: AppInstructorState(),
    middleware: [
      LoggingMiddleware.printer(),
    ],
  );
}
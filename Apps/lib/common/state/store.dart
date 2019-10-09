import 'package:funlab/common/state/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'state.dart';

Store<AppState> createStore() {
  return Store(
    appReducer,
    initialState: AppState(),
    middleware: [
      LoggingMiddleware.printer(),
    ],
  );
}

typedef OnStateChanged = Function(dynamic);

import 'package:funlab/common/state/reducer.dart';
import 'package:funlab/common/state/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

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


import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/reducers/app_reducer.dart';
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
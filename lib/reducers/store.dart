
import 'package:funlab/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:funlab/reducers/app_reducer.dart';

Store<AppState> createStore() {
  return Store(
    appReducer,
    initialState: AppState(),
    middleware: [
      LoggingMiddleware.printer(),
    ],
  );
}
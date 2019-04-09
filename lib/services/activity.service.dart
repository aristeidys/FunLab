import 'package:funlab/models/assignment.mode.dart';
import 'package:funlab/services/service.dart';

class ActivityService extends HttpService {
  
  @override
  final endpoint = '/activities/';

  createActivity(Activity entity, ResponceCallback callback) {
    postRequest(entity, callback);
  }
}

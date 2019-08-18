import 'package:funlab/common/models/student.model.dart';
import 'package:funlab/common/services/base.service.dart';

class StudentService extends HttpService<Student> {
  
  @override
  final endpoint = '/students/';
}

import 'package:funlab/common/widgets/custom_list_view.dart';

class Student implements Listable {
  final String name;

  Student({this.name});

  Student fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] as String,
    );
  }

    Map<String, dynamic> toJson() => {
        'name': name
      };
}
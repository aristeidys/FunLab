
class LabSession {
  final String title;
  final bool finished;
 
  LabSession({this.title, this.finished});
 
  factory LabSession.fromJson(Map<String, dynamic> json) {
    return LabSession(
      title: json['title'] as String,
      finished: json['finished'] as bool,
    );
  }
}
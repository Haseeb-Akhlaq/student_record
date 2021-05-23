class Student {
  String studentId;
  String studentName;
  String profilePic;

  Student({this.studentId, this.profilePic, this.studentName});

  Student.fromMap(Map<dynamic, dynamic> map) {
    this.studentName = map['studentName'] ?? '';
    this.studentId = map['studentId'] ?? '';
    this.profilePic = map['profilePic'] ?? '';
  }
}

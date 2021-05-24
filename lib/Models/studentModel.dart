class Student {
  String studentId;
  String studentName;
  String profilePic;

  bool attendanceWeek1;
  bool attendanceWeek2;
  bool attendanceWeek3;
  bool attendanceWeek4;
  bool attendanceWeek5;
  bool attendanceWeek6;
  bool attendanceWeek7;
  bool attendanceWeek8;
  bool attendanceWeek9;
  bool attendanceWeek10;
  bool attendanceWeek11;
  bool attendanceWeek12;

  String marksWeek1;
  String marksWeek2;
  String marksWeek3;
  String marksWeek4;
  String marksWeek5;
  String marksWeek6;
  String marksWeek7;
  String marksWeek8;
  String marksWeek9;
  String marksWeek10;
  String marksWeek11;
  String marksWeek12;

  Student({
    this.studentId,
    this.profilePic,
    this.studentName,
    this.attendanceWeek1,
    this.attendanceWeek2,
    this.attendanceWeek3,
    this.attendanceWeek4,
    this.attendanceWeek5,
    this.attendanceWeek6,
    this.attendanceWeek7,
    this.attendanceWeek8,
    this.attendanceWeek9,
    this.attendanceWeek10,
    this.attendanceWeek11,
    this.attendanceWeek12,
    this.marksWeek1,
    this.marksWeek2,
    this.marksWeek3,
    this.marksWeek4,
    this.marksWeek5,
    this.marksWeek6,
    this.marksWeek7,
    this.marksWeek8,
    this.marksWeek9,
    this.marksWeek10,
    this.marksWeek11,
    this.marksWeek12,
  });

  Student.fromMap(Map<dynamic, dynamic> map) {
    this.studentName = map['studentName'] ?? '';
    this.studentId = map['studentId'] ?? '';
    this.profilePic = map['profilePic'] ?? '';
    this.attendanceWeek1 = map['attendanceWeek1'];
    this.attendanceWeek2 = map['attendanceWeek2'];
    this.attendanceWeek3 = map['attendanceWeek3'];
    this.attendanceWeek4 = map['attendanceWeek4'];
    this.attendanceWeek5 = map['attendanceWeek5'];
    this.attendanceWeek6 = map['attendanceWeek6'];
    this.attendanceWeek7 = map['attendanceWeek7'];
    this.attendanceWeek8 = map['attendanceWeek8'];
    this.attendanceWeek9 = map['attendanceWeek9'];
    this.attendanceWeek10 = map['attendanceWeek10'];
    this.attendanceWeek11 = map['attendanceWeek11'];
    this.attendanceWeek12 = map['attendanceWeek12'];
    this.marksWeek1 = map['marksWeek1'];
    this.marksWeek2 = map['marksWeek2'];
    this.marksWeek3 = map['marksWeek3'];
    this.marksWeek4 = map['marksWeek4'];
    this.marksWeek1 = map['marksWeek5'];
    this.marksWeek2 = map['marksWeek6'];
    this.marksWeek3 = map['marksWeek7'];
    this.marksWeek4 = map['marksWeek8'];
    this.marksWeek1 = map['marksWeek9'];
    this.marksWeek2 = map['marksWeek10'];
    this.marksWeek3 = map['marksWeek11'];
    this.marksWeek4 = map['marksWeek12'];
  }
}

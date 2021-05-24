import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Models/studentModel.dart';

enum Markings {
  percentage,
  checkBoxes,
  grades,
  HdGrades,
}

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  bool isLoading = false;
  List<Student> allStudents = [];

  int selectedWeek = 1;
  Markings selectedMarking = Markings.percentage;

  getAllStudents() async {
    setState(() {
      isLoading = true;
    });

    final students =
        await FirebaseFirestore.instance.collection('students').get();

    students.docs.forEach((element) {
      allStudents.add(Student.fromMap(element.data()));
    });

    setState(() {
      isLoading = false;
    });
  }

  reset() {
    allStudents = [];
    getAllStudents();
  }

  @override
  void initState() {
    getAllStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Record'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 20, right: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Week',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      DropdownButton(
                          onChanged: (v) {
                            setState(() {
                              selectedWeek = v;
                              print(v);
                            });
                            reset();
                          },
                          value: selectedWeek,
                          items: [
                            DropdownMenuItem(
                              child: Text('Week 1'),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 2'),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 3'),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 4'),
                              value: 4,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 5'),
                              value: 5,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 6'),
                              value: 6,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 7'),
                              value: 7,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 8'),
                              value: 8,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 9'),
                              value: 9,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 10'),
                              value: 10,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 11'),
                              value: 11,
                            ),
                            DropdownMenuItem(
                              child: Text('Week 12'),
                              value: 12,
                            ),
                          ])
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 20, right: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Marking Method',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      DropdownButton(
                          onChanged: (v) {
                            setState(() {
                              selectedMarking = v;
                              print(v);
                            });
                          },
                          value: selectedMarking,
                          items: [
                            DropdownMenuItem(
                              child: Text('Percent'),
                              value: Markings.percentage,
                            ),
                            DropdownMenuItem(
                              child: Text('Check Points'),
                              value: Markings.checkBoxes,
                            ),
                            DropdownMenuItem(
                              child: Text('Grade Level'),
                              value: Markings.grades,
                            ),
                            DropdownMenuItem(
                              child: Text('Grade HDL'),
                              value: Markings.HdGrades,
                            ),
                          ])
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: allStudents.length,
                        itemBuilder: (context, index) {
                          return StudentMarkingTile(
                            student: allStudents[index],
                            selectedMarking: selectedMarking,
                            selectedWeek: selectedWeek,
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class StudentMarkingTile extends StatefulWidget {
  final Student student;
  final int selectedWeek;
  final Markings selectedMarking;

  StudentMarkingTile({
    this.student,
    this.selectedWeek,
    this.selectedMarking,
  });
  @override
  _StudentMarkingTileState createState() => _StudentMarkingTileState();
}

class _StudentMarkingTileState extends State<StudentMarkingTile> {
  bool getWeekAttendance(Student student, int selectedWeek) {
    if (selectedWeek == 1) {
      return student.attendanceWeek1;
    }
    if (selectedWeek == 2) {
      return student.attendanceWeek2;
    }
    if (selectedWeek == 3) {
      print('3');
      return student.attendanceWeek3;
    }
    if (selectedWeek == 4) {
      return student.attendanceWeek4;
    }
    if (selectedWeek == 5) {
      return student.attendanceWeek5;
    }
    if (selectedWeek == 6) {
      return student.attendanceWeek6;
    }
    if (selectedWeek == 7) {
      return student.attendanceWeek7;
    }
    if (selectedWeek == 8) {
      return student.attendanceWeek8;
    }
    if (selectedWeek == 9) {
      return student.attendanceWeek9;
    }
    if (selectedWeek == 10) {
      return student.attendanceWeek10;
    }
    if (selectedWeek == 11) {
      return student.attendanceWeek11;
    }
    if (selectedWeek == 12) {
      return student.attendanceWeek12;
    }
    return false;
  }

  markAttendance() {
    FirebaseFirestore.instance
        .collection('students')
        .doc(widget.student.studentId)
        .update({'attendanceWeek${widget.selectedWeek}': attendance});
  }

  changeMarks(String marks) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(widget.student.studentId)
        .update({'marksWeek${widget.selectedWeek}': marks});
  }

  bool attendance = false;

  bool checkPoint1 = false;
  bool checkPoint2 = false;
  bool checkPoint3 = false;

  Widget markingMethods(Markings markingMethod) {
    if (markingMethod == Markings.percentage) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            width: 50,
            child: TextField(
              textAlign: TextAlign.center,
              onChanged: (v) {
                changeMarks(v);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '0-100',
                  hintStyle: TextStyle(
                    fontSize: 12,
                  )),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
            ),
          ),
          Text(
            '  / 100',
            style: TextStyle(color: Colors.black),
          )
        ],
      );
    }
    if (markingMethod == Markings.checkBoxes) {
      return Row(
        children: [
          Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: checkPoint1,
              onChanged: (v) {
                setState(() {
                  checkPoint1 = v;
                });
              }),
          Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: checkPoint2,
              onChanged: (v) {
                setState(() {
                  checkPoint2 = v;
                });
              }),
          Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: checkPoint3,
              onChanged: (v) {
                setState(() {
                  checkPoint3 = v;
                });
              }),
          Container(
            height: 35,
            width: 2,
            color: Colors.grey,
          )
        ],
      );
    }
    return Container();
  }

  @override
  void initState() {
    attendance = getWeekAttendance(widget.student, widget.selectedWeek);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    attendance = getWeekAttendance(widget.student, widget.selectedWeek);
    checkPoint1 = false;
    checkPoint2 = false;
    checkPoint3 = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      trailing: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: markingMethods(widget.selectedMarking)),
            Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: attendance,
                onChanged: (v) {
                  setState(() {
                    attendance = v;
                    markAttendance();
                  });
                })
          ],
        ),
      ),
      title: Text(
        widget.student.studentName,
        style: TextStyle(fontSize: 20),
      ),
      subtitle: Text(
        widget.student.studentId,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

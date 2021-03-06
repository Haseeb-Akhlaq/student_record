import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:students_record_app/screens/add_record_screen.dart';
import 'package:students_record_app/screens/studentRecordScreen.dart';

import '../Models/studentModel.dart';

class WeeklyMarkingScreen extends StatefulWidget {
  @override
  _WeeklyMarkingScreenState createState() => _WeeklyMarkingScreenState();
}

class _WeeklyMarkingScreenState extends State<WeeklyMarkingScreen> {
  bool isLoading = false;
  List<Student> allStudents = [];

  int selectedWeek = 1;

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

  String getWeekScore(Student student, int selectedWeek) {
    if (selectedWeek == 1) {
      return student.marksWeek1;
    }
    if (selectedWeek == 2) {
      return student.marksWeek2;
    }
    if (selectedWeek == 3) {
      print('3');
      return student.marksWeek3;
    }
    if (selectedWeek == 4) {
      return student.marksWeek4;
    }
    if (selectedWeek == 5) {
      return student.marksWeek5;
    }
    if (selectedWeek == 6) {
      return student.marksWeek6;
    }
    if (selectedWeek == 7) {
      return student.marksWeek7;
    }
    if (selectedWeek == 8) {
      return student.marksWeek8;
    }
    if (selectedWeek == 9) {
      return student.marksWeek9;
    }
    if (selectedWeek == 10) {
      return student.marksWeek10;
    }
    if (selectedWeek == 11) {
      return student.marksWeek11;
    }
    if (selectedWeek == 12) {
      return student.marksWeek12;
    }
    return '';
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
        title: Text('Markings'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CoursesSearch(
                  allStudents: allStudents,
                  getWeekAttendance: getWeekAttendance,
                  getWeekScore: getWeekScore,
                  selectedWeek: selectedWeek,
                ),
              );
            },
          ),
        ],
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
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '     Name',
                        style: TextStyle(fontSize: 18),
                      ),
                      Row(
                        children: [
                          Text(
                            'A            ',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'S      ',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
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
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentRecordScreen(
                                    student: allStudents[index],
                                  ),
                                ),
                              );
                            },
                            minLeadingWidth: 0,
                            trailing: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: 80,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${getWeekAttendance(allStudents[index], selectedWeek) ? 'Y' : 'N'}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    getWeekScore(
                                        allStudents[index], selectedWeek),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            title: Text(
                              allStudents[index].studentName,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              allStudents[index].rollNumber.trim(),
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddRecordScreen(selectedWeek: selectedWeek),
                        ),
                      );
                      if (result == null) {
                        reset();
                      }
                    },
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
                        'Add Record',
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

class CoursesSearch extends SearchDelegate<String> {
  final List<Student> allStudents;
  final Function getWeekAttendance;
  final Function getWeekScore;
  final int selectedWeek;

  CoursesSearch(
      {this.allStudents,
      this.getWeekAttendance,
      this.selectedWeek,
      this.getWeekScore});

  List<Student> searchResults(String query) {
    if (query.isEmpty) {
      return allStudents;
    }

    return allStudents
        .where((element) => element.rollNumber.contains(query))
        .toList();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Student> results = query.isEmpty ? allStudents : searchResults(query);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentRecordScreen(
                        student: allStudents[index],
                      ),
                    ),
                  );
                },
                minLeadingWidth: 0,
                trailing: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getWeekAttendance(results[index], selectedWeek) ? 'Y' : 'N'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        getWeekScore(results[index], selectedWeek),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  results[index].studentName,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  results[index].rollNumber.trim(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }),
    );
  }
}

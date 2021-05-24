import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                            'A     ',
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
                          return GestureDetector(
                            onTap: () {},
                            child: ListTile(
                              minLeadingWidth: 0,
                              trailing: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                width: 50,
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
                                      allStudents[index].marksWeek1,
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
                                allStudents[index].studentId.trim(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
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
  CoursesSearch({this.allStudents});

  List<Student> searchResults(String query) {
    if (query.isEmpty) {
      return allStudents;
    }

    return allStudents.where((element) => element.studentId == query).toList();
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
  Widget buildResults(BuildContext context) {}

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
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    minLeadingWidth: 0,
                    trailing: Container(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Y'),
                          Text('23'),
                        ],
                      ),
                    ),
                    leading: Container(
                      width: 80,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(allStudents[index].profilePic),
                        radius: 30,
                      ),
                    ),
                    title: Text(
                      allStudents[index].studentName,
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      allStudents[index].studentId.trim(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

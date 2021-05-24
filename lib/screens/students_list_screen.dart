import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:students_record_app/Models/studentModel.dart';
import 'package:students_record_app/screens/editStudentScreen.dart';

class StudentsListScreen extends StatefulWidget {
  @override
  _StudentsListScreenState createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  bool isLoading = false;
  List<Student> allStudents = [];

  deleteUserFromFirebase(String id) async {
    try {
      await FirebaseFirestore.instance.collection('students').doc(id).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error'),
          backgroundColor: Colors.red,
        ),
      );
    }
    Navigator.of(context).pop();
    setState(() {
      allStudents.removeWhere((element) => element.studentId == id);
    });
  }

  deleteUserDialog(BuildContext ctx, String studentId) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text("Warning"),
        content: Text("Are you sure you want to Delete User?"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue,
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                deleteUserFromFirebase(studentId);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red,
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

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
        title: Text('All Students'),
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
                    reset: reset,
                    deleteUser: deleteUserDialog),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: allStudents.length,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditStudentScreen(
                                            student: allStudents[index],
                                          ),
                                        ),
                                      );
                                      if (result == true) {
                                        reset();
                                      }
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      deleteUserDialog(context,
                                          allStudents[index].studentId);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
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
            ),
    );
  }
}

class CoursesSearch extends SearchDelegate<String> {
  final List<Student> allStudents;
  final Function deleteUser;
  final Function reset;

  CoursesSearch({this.allStudents, this.reset, this.deleteUser});

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
                          GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditStudentScreen(
                                    student: allStudents[index],
                                  ),
                                ),
                              );
                              if (result == true) {
                                reset();
                              }
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              deleteUser(context, allStudents[index].studentId);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:students_record_app/Models/studentModel.dart';
import 'package:students_record_app/screens/editStudentScreen.dart';

class StudentRecordScreen extends StatefulWidget {
  final Student student;

  const StudentRecordScreen({this.student});
  @override
  _StudentRecordScreenState createState() => _StudentRecordScreenState();
}

class _StudentRecordScreenState extends State<StudentRecordScreen> {
  Student student;

  String calculateTotal() {
    final total = double.parse(widget.student.marksWeek1) +
        double.parse(widget.student.marksWeek2) +
        double.parse(widget.student.marksWeek3) +
        double.parse(widget.student.marksWeek4) +
        double.parse(widget.student.marksWeek5) +
        double.parse(widget.student.marksWeek6) +
        double.parse(widget.student.marksWeek7) +
        double.parse(widget.student.marksWeek8) +
        double.parse(widget.student.marksWeek9) +
        double.parse(widget.student.marksWeek10) +
        double.parse(widget.student.marksWeek11) +
        double.parse(widget.student.marksWeek12);

    return total.toString();
  }

  String calculateOverAll() {
    final percentage = (double.parse(calculateTotal()) / 12).toStringAsFixed(2);

    return percentage.toString();
  }

  resetStudent(String imageUrl, String name, String id) {
    setState(() {
      student.profilePic = imageUrl;
      student.studentName = name;
      student.rollNumber = id;
    });
  }

  @override
  void initState() {
    student = widget.student;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: student.profilePic,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        student.studentName,
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      subtitle: Text(
                        student.rollNumber,
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      trailing: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStudentScreen(
                                student: student,
                                editFromRecord: resetStudent,
                                secondEdit: true,
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.20),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Week   1:            ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek1,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   2:            ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek2,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   3:            ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek3,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   4:            ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek4,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   5:            ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek5,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   6:            ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek6,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   7:            ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek7,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   8:            ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek8,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   9:            ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek9,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   10:          ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek10,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   11:           ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek11,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Week   12:          ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          widget.student.marksWeek12,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              )),
              SizedBox(height: 10),
              Text(
                'Total:          ${calculateTotal()}',
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
              SizedBox(height: 10),
              Text(
                'Semester OverAll:      ${calculateOverAll()}%',
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Share.share(
                          'Name: ${widget.student.studentName} \n'
                          'ID : ${widget.student.rollNumber} \n'
                          'Week No 1 :   ${widget.student.marksWeek1} \n'
                          'Week No 2 :   ${widget.student.marksWeek2} \n'
                          'Week No 3 :   ${widget.student.marksWeek3} \n'
                          'Week No 4 :   ${widget.student.marksWeek4} \n'
                          'Week No 5 :   ${widget.student.marksWeek5} \n'
                          'Week No 6 :   ${widget.student.marksWeek6} \n'
                          'Week No 7 :   ${widget.student.marksWeek7} \n'
                          'Week No 8 :   ${widget.student.marksWeek8} \n'
                          'Week No 9 :   ${widget.student.marksWeek9} \n'
                          'Week No 10    ${widget.student.marksWeek10} \n'
                          'Week No 11 :  ${widget.student.marksWeek11} \n'
                          'Week No 12 :  ${widget.student.marksWeek12} \n'
                          'Total :   ${calculateTotal()} \n'
                          'OverAll :   ${calculateOverAll()} % \n',
                          subject: 'Best app!');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Share Data',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

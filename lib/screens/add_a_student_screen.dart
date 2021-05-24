import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:toast/toast.dart';

class AddAStudentScreen extends StatefulWidget {
  @override
  _AddAStudentScreenState createState() => _AddAStudentScreenState();
}

class _AddAStudentScreenState extends State<AddAStudentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isUploading = false;
  bool isLoading = false;

  String studentName = '';
  String studentId = '';

  File _image;
  final picker = ImagePicker();
  String imageUrl = '';

  saveData(BuildContext context) async {
    bool isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    try {
      setState(() {
        isLoading = true;
      });
      final studentPath =
          FirebaseFirestore.instance.collection('students').doc(studentId);

      final studentData = await studentPath.get();

      if (studentData.exists) {
        Toast.show("Student Already Exists", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        await FirebaseFirestore.instance
            .collection('students')
            .doc(studentId)
            .set({
          'studentName': studentName,
          'studentId': studentId,
          'profilePic': imageUrl == ''
              ? 'https://static.thenounproject.com/png/630740-200.png'
              : imageUrl,
          'attendanceWeek1': false,
          'attendanceWeek2': false,
          'attendanceWeek3': false,
          'attendanceWeek4': false,
          'attendanceWeek5': false,
          'attendanceWeek6': false,
          'attendanceWeek7': false,
          'attendanceWeek8': false,
          'attendanceWeek9': false,
          'attendanceWeek10': false,
          'attendanceWeek11': false,
          'attendanceWeek12': false,
          'marksWeek1': '0',
          'marksWeek2': '0',
          'marksWeek3': '0',
          'marksWeek4': '0',
          'marksWeek5': '0',
          'marksWeek6': '0',
          'marksWeek7': '0',
          'marksWeek8': '0',
          'marksWeek9': '0',
          'marksWeek10': '0',
          'marksWeek11': '0',
          'marksWeek12': '0',
        });
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );

    if (pickedFile != null) {
      setState(() {
        isUploading = true;
      });

      _image = File(pickedFile.path);
      String fileName = basename(pickedFile.path);

      final firebaseStorageRef =
          FirebaseStorage.instance.ref().child('profilePics/$fileName');

      final uploadTask = firebaseStorageRef.putFile(_image);

      final taskSnapshot =
          await uploadTask.whenComplete(() => print('image uploaded'));

      uploadTask.asStream().listen((event) {
        print('wqdddddd');
        print(event.bytesTransferred / event.totalBytes);
      });

      taskSnapshot.ref.getDownloadURL().then(
        (value) {
          setState(() {
            imageUrl = value;
            print("Done: $value");
            isUploading = false;
          });
        },
      );
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Student'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(_image == null
                        ? 'https://static.thenounproject.com/png/630740-200.png'
                        : imageUrl),
                    child:
                        isUploading ? CircularProgressIndicator() : Container(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.photo,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Pick Image',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 10, top: 5, bottom: 5),
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    hintText: 'Student Name',
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (value) {
                                    studentName = value;
                                  },
                                  validator: (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Please enter valid Name';
                                    }
                                    if (value.length > 25) {
                                      return 'Please Enter Name less than 25 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 10, top: 5, bottom: 5),
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Student Id',
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (value) {
                                    studentId = value;
                                  },
                                  validator: (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Please enter a valid Id';
                                    }
                                    if (value.trim().length != 4) {
                                      return 'Id must be of 4 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () {
                              saveData(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Add Student',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

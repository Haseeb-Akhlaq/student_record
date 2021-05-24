import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:students_record_app/Models/studentModel.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  const EditStudentScreen({this.student});
  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isUploading = false;
  bool isLoading = false;

  File _image;
  final picker = ImagePicker();
  String imageUrl = '';

  setStudent() {
    nameController.text = widget.student.studentName;
    imageUrl = widget.student.profilePic;
  }

  updateData(BuildContext context) async {
    bool isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('students')
        .doc(widget.student.studentId)
        .update({
      'studentName': nameController.text,
      'profilePic': imageUrl,
    });

    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop(true);
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
  void initState() {
    setStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
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
                    backgroundImage: NetworkImage(imageUrl == ''
                        ? 'https://static.thenounproject.com/png/630740-200.png'
                        : imageUrl),
                    child:
                        isUploading ? CircularProgressIndicator() : Container(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      getImage();
                    },
                    icon: Icon(
                      Icons.photo,
                      color: Colors.blue,
                    ),
                    label: Text(
                      'Change Image',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
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
                                  controller: nameController,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    hintText: 'Student Name',
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (value) {
                                    nameController.text = value;
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
                          ],
                        ),
                      ),
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () {
                              updateData(context);
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
                                  'Update',
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

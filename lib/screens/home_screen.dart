import 'package:flutter/material.dart';
import 'package:students_record_app/screens/weeklyMarkingsScreen.dart';

import 'file:///C:/Users/haseeb/AndroidStudioProjects/students_record_app/lib/screens/add_a_student_screen.dart';
import 'file:///C:/Users/haseeb/AndroidStudioProjects/students_record_app/lib/screens/students_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeScreenButton(
                text: 'Add Student',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAStudentScreen(),
                    ),
                  );
                }),
            SizedBox(height: 40),
            HomeScreenButton(
                text: 'Students List',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentsListScreen(),
                    ),
                  );
                }),
            SizedBox(height: 40),
            HomeScreenButton(
                text: 'Weekly Markings',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeeklyMarkingScreen(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class HomeScreenButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const HomeScreenButton({this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

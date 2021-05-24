import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/haseeb/AndroidStudioProjects/students_record_app/lib/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'bolt-regular',
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
            ),
          )),
      home: HomeScreen(),
    );
  }
}

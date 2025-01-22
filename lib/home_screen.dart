import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:database_management/database_Manager.dart';
import 'package:database_management/form_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: "Database",
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'This is a Student Database',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          backgroundColor: CupertinoColors.activeBlue,
        ),
        backgroundColor:const Color.fromARGB(242, 150, 241, 222),
        body: const FormScreen(),
      ),
    );
  }
}

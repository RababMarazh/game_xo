import 'package:flutter/material.dart';
import 'package:gamexo/homepage.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.indigo,
      primaryColor:  Color.fromARGB(255, 129, 71, 139),
      shadowColor: Color.fromARGB(255, 218, 110, 146)

      ),
      home:  HomePage(),
    );
  }
}

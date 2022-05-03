import 'package:arquidiocese_maceio_app/screens/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.blue[900],
        title: 'Centenário Arquidiocese de Maceió',
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}

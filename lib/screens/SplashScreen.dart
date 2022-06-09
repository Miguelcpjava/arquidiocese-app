import 'dart:async';

import 'package:arquidiocese_maceio_app/screens/DashScreen.dart';
import 'package:arquidiocese_maceio_app/screens/NoticiasScreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });

    Timer(const Duration(seconds: 7), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoticiasScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? Shimmer.fromColors(
                    child: Image.asset('assets/img/arqbrasao.png'),
                    baseColor: Colors.white10,
                    highlightColor: Colors.grey,
                    period: Duration(seconds: 3),
                  )
                : Image.asset('assets/img/arqbrasao.png'),
            SizedBox(
              height: 10,
            ),
            Text(
              "Carregando...",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

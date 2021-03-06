import 'dart:async';

import 'package:arquidiocese_maceio_app/src/screens/NoticiasScreen.dart';
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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoticiasScreen()));
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
                    period: const Duration(seconds: 3),
                  )
                : Image.asset('assets/img/arqbrasao.png'),
            const SizedBox(
              height: 10,
            ),
            const Text(
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

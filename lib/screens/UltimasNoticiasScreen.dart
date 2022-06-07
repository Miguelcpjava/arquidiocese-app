import 'package:arquidiocese_maceio_app/data/Constants.dart';
import 'package:arquidiocese_maceio_app/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';

class UltimasNoticiasScreen extends StatefulWidget {
  const UltimasNoticiasScreen({Key? key}) : super(key: key);

  @override
  State<UltimasNoticiasScreen> createState() => _UltimasNoticiasScreenState();
}

class _UltimasNoticiasScreenState extends State<UltimasNoticiasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: darkBlue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 55,
                ),
                Center(
                  child: Image.asset(
                    "assets/img/arqbrasao.png",
                    alignment: Alignment.centerRight,
                    width: 120,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Arquidiocese de Maceió",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.none)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

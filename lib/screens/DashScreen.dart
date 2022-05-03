import 'package:arquidiocese_maceio_app/widgets/CardsMenu.dart';
import 'package:flutter/material.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({Key? key}) : super(key: key);

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Center(
            child: Image.asset(
              "assets/img/arqbrasao.png",
              alignment: Alignment.centerRight,
              scale: .99,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Arquidiocese de Maceió",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: <Widget>[
              CardsMenu(
                  height: 100.0,
                  icon: Icons.newspaper,
                  text: "Últimas Noticias")
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.youtube_searched_for),
              Icon(Icons.insert_page_break),
              Icon(Icons.facebook),
            ],
          )
        ],
      ),
    );
  }
}

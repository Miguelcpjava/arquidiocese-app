import 'package:arquidiocese_maceio_app/data/Constants.dart';
import 'package:arquidiocese_maceio_app/screens/NoticiasScreen.dart';
import 'package:arquidiocese_maceio_app/widgets/CardsMenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            height: 60,
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
          GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NoticiasScreen()),
                ),
                child: CardsMenu(
                    height: 100.0,
                    icon: Icons.newspaper,
                    text: "Últimas Noticias"),
              ),
              CardsMenu(height: 100.0, icon: Icons.podcasts, text: "Podcasts"),
              CardsMenu(height: 100.0, icon: Icons.church, text: "Paróquias"),
              CardsMenu(
                  height: 100.0,
                  icon: Icons.video_library_outlined,
                  text: "Videos"),
              CardsMenu(
                  height: 100.0,
                  icon: FontAwesomeIcons.handsPraying,
                  text: "Pedido de Oração"),
              CardsMenu(height: 100.0, icon: Icons.contacts, text: "Contato"),
              CardsMenu(
                  height: 100.0,
                  icon: FontAwesomeIcons.church,
                  text: "Santuário"),
              CardsMenu(
                  height: 100.0,
                  icon: FontAwesomeIcons.cross,
                  text: "Seminários e Conventos"),
              GestureDetector(
                onTap: () => print("Curia"),
                child: CardsMenu(
                    height: 100.0,
                    icon: pope_crown,
                    text: "Cúria Metropolitana"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/img/youtubeicon.png",
                color: Colors.yellow[500],
                width: 60,
                height: 60,
              ),
              Image.asset(
                "assets/img/instagram.png",
                color: Colors.yellow[500],
                width: 50,
                height: 50,
              ),
              Icon(
                Icons.facebook,
                color: Colors.yellow[500],
                size: 55.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}

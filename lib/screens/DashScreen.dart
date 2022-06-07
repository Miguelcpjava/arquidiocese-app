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
                    text: "Últimas Noticias",
                    clazz: DashScreen()),
              ),
              CardsMenu(
                  height: 100.0,
                  icon: Icons.podcasts,
                  text: "Podcasts",
                  clazz: DashScreen()),
              CardsMenu(
                  height: 100.0,
                  icon: Icons.church,
                  text: "Paróquias",
                  clazz: DashScreen()),
              CardsMenu(
                  height: 100.0,
                  icon: Icons.video_library_outlined,
                  text: "Videos",
                  clazz: DashScreen()),
              CardsMenu(
                  height: 100.0,
                  icon: FontAwesomeIcons.handsPraying,
                  text: "Pedido de Oração",
                  clazz: DashScreen()),
              CardsMenu(
                  height: 100.0,
                  icon: Icons.contacts,
                  text: "Contato",
                  clazz: DashScreen()),
              CardsMenu(
                  height: 100.0,
                  icon: FontAwesomeIcons.church,
                  text: "Santuário",
                  clazz: DashScreen()),
              CardsMenu(
                  height: 100.0,
                  icon: FontAwesomeIcons.cross,
                  text: "Seminários e Conventos",
                  clazz: DashScreen()),
              GestureDetector(
                onTap: () => print("Curia"),
                child: CardsMenu(
                    height: 100.0,
                    icon: pope_crown,
                    text: "Cúria Metropolitana",
                    clazz: DashScreen()),
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

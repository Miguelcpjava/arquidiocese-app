import 'package:arquidiocese_maceio_app/data/DataMenu.dart';
import 'package:arquidiocese_maceio_app/widgets/CardsMenu.dart';
import 'package:flutter/material.dart';

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({Key? key}) : super(key: key);

  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}

//https://stackoverflow.com/questions/60978347/stack-an-image-in-two-widgets-flutter
class _NoticiasScreenState extends State<NoticiasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[900],
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
                SizedBox(
                  height: 115,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: menus.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CardsMenu(
                              height: menus[index].height,
                              icon: menus[index].icon,
                              text: menus[index].title),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListTile(
                        title: Text("Example"),
                        subtitle: Text("SubExample"),
                        leading: Image.asset("assets/img/pascom-brasil.jpeg"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:arquidiocese_maceio_app/screens/Paroquia/ParoquiaScreen.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey.withAlpha(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xffFDCF09),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/img/arqbrasao.png'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Arquidiocese de Maceió"),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              debugPrint("Selecionou as notas");
            },
            leading: const Icon(Icons.movie),
            title: const Text("Vídeos"),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Selecionou a frequencia");
            },
            leading: const Icon(Icons.fiber_new_sharp),
            title: const Text("Frequência"),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Selecionou as atividades");
            },
            leading: const Icon(Icons.assignment),
            title: const Text("Eventos"),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ParoquiaScreen()));
            },
            leading: const Icon(Icons.location_city_rounded),
            title: const Text("Paróquias"),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Selecionou saída");
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Sair"),
          ),
        ],
      ),
    );
  }
}

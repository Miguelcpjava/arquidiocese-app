import 'package:arquidiocese_maceio_app/models/Paroquia.dart';
import 'package:flutter/material.dart';

class ParoquiaDetalhe extends StatelessWidget {
  final Paroquia paroquia;

  const ParoquiaDetalhe({Key? key, required this.paroquia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(paroquia.nomeParoquia!),
        backgroundColor: Color.fromRGBO(5, 31, 53, .5),
        actions: [],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.4,
            child: Hero(
              tag: paroquia.nomeParoquia!,
              child: Image.asset(
                "assets/img/ImageNA.png",
                height: size.height * 0.4,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: size.height * 0.7,
            width: double.infinity,
            margin: EdgeInsets.only(top: size.height * 0.35),
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    paroquia.nomeParoquia!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      Text(
                        paroquia.bairroParoquia!,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      Spacer(),
                      Icon(Icons.phone),
                      Text(paroquia.telefoneParoquia!)
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/img/padre-icon.png",
                        width: 24,
                      ),
                      Text(paroquia.nomeParoco!),
                      Spacer(),
                      Image.asset(
                        "assets/img/whatsapp-icone-1.png",
                        width: 24,
                      ),
                      Text(paroquia.whatsParoquia!)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    paroquia.descricaoParoquia!,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

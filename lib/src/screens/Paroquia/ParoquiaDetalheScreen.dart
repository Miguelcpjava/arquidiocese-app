import 'package:arquidiocese_maceio_app/src/models/Paroquia.dart';
import 'package:flutter/material.dart';

class ParoquiaDetalhe extends StatelessWidget {
  final Paroquia paroquia;

  const ParoquiaDetalhe({Key? key, required this.paroquia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(paroquia.nome!),
        backgroundColor: const Color.fromRGBO(5, 31, 53, .5),
        actions: const [],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.4,
            child: Hero(
              tag: paroquia.nome!,
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
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
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
                    paroquia.nome!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.location_on),
                      Text(
                        paroquia.igreja!.first.endereco!,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      const Spacer(),
                      const Icon(Icons.phone),
                      Text(paroquia.telefone!)
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/img/padre-icon.png",
                        width: 24,
                      ),
                      Text(paroquia.igreja!.first.vigario!),
                      const Spacer(),
                      Image.asset(
                        "assets/img/whatsapp-icone-1.png",
                        width: 24,
                      ),
                      Text(paroquia.whatsapp!)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    paroquia.igreja!.first.historia!,
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

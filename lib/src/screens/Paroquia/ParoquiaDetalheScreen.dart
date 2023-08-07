import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/models/Igreja.dart';
import 'package:arquidiocese_maceio_app/src/models/Paroquia.dart';
import 'package:flutter/material.dart';

class ParoquiaDetalhe extends StatelessWidget {
  final Paroquia paroquia;
  final Igreja igreja;

  const ParoquiaDetalhe(
      {Key? key, required this.paroquia, required this.igreja})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(paroquia.nome!),
        backgroundColor: darkBlue,
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
                    igreja.nome!,
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
                        igreja.endereco!,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
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
                      Text(igreja.vigario!),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/img/whatsapp-icone-1.png",
                        width: 24,
                      ),
                      Text(paroquia.whatsapp!)
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: darkBlue,
                  ),
                  const Text("Horários das Missas"),
                  Text("Segunda: ${igreja.missa!.segunda}"),
                  Text("Terça: ${igreja.missa!.terca}"),
                  Text("Quarta: ${igreja.missa!.quarta}"),
                  Text("Quinta: ${igreja.missa!.quinta}"),
                  Text("Sexta: ${igreja.missa!.sexta}"),
                  Text("Sabado: ${igreja.missa!.sabado}"),
                  Text("Domingo: ${igreja.missa!.domingo}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/data/DataModel.dart';
import 'package:arquidiocese_maceio_app/src/models/Diocese.dart';
import 'package:arquidiocese_maceio_app/src/models/Igreja.dart';
import 'package:arquidiocese_maceio_app/src/models/Paroquia.dart';
import 'package:arquidiocese_maceio_app/src/screens/Paroquia/ParoquiaDetalheScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParoquiaScreen extends StatefulWidget {
  @override
  _ParoquiaScreenState createState() => _ParoquiaScreenState();
}

class _ParoquiaScreenState extends State<ParoquiaScreen> {
  TextEditingController editingController = TextEditingController();
  List<Igreja> listaOriginal = [];
  Diocese arquidiocese = Diocese();

  @override
  void initState() {
    fetchDiocese();
    super.initState();
  }

  Future<Diocese> getData() async {
    final response = await rootBundle.loadString("assets/data/paroquias.json");
    final decoded = jsonDecode(response);
    return Diocese.fromJson(decoded);
  }

  Future<void> fetchDiocese() async {
    final fetched = await getData();
    arquidiocese = fetched;
    debugPrint("Diocese achada: ${arquidiocese.diocese}");
  }

  void procurarPorBairro(String bairro) {
    List<Igreja> listaResultado = [];
    if (bairro.isNotEmpty) {
      listaResultado.clear();
      for (var item in arquidiocese.cidade!.bairro!) {
        if (item.nome!.contains(bairro)) {
          for (var index in item.paroquia!.igreja!) {
            listaResultado.add(index);
          }
        }
      }
      setState(() {
        listaOriginal.clear();
        listaOriginal.addAll(listaResultado);
      });
      return;
    } else {
      setState(() {
        listaOriginal.clear();
        for (var zindex in arquidiocese.cidade!.bairro!) {
          listaOriginal.addAll(zindex.paroquia!.igreja!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: darkBlue,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios),
                      color: yellowAccenture),
                ),
              ),
              const Center(
                child: Icon(
                  Icons.church,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Paróquias",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.none)),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

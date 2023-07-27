import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/data/DataModel.dart';
import 'package:arquidiocese_maceio_app/src/models/Paroquia.dart';
import 'package:arquidiocese_maceio_app/src/screens/Paroquia/ParoquiaDetalheScreen.dart';
import 'package:flutter/material.dart';

class ParoquiaScreen extends StatefulWidget {
  @override
  _ParoquiaScreenState createState() => _ParoquiaScreenState();
}

class _ParoquiaScreenState extends State<ParoquiaScreen> {
  TextEditingController editingController = TextEditingController();
  List<Paroquia> listaOriginal = [];

  @override
  void initState() {
    listaOriginal.addAll(paroquias);
    super.initState();
  }

  void procurarPorBairro(String bairro) {
    List<Paroquia> listaResultado = [];
    if (bairro.isNotEmpty) {
      listaResultado.clear();
      for (var item in paroquias) {
        if (item.bairroParoquia!.contains(bairro)) {
          listaResultado.add(item);
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
        listaOriginal.addAll(paroquias);
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

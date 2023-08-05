import 'dart:convert';

import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/data/DataModel.dart';
import 'package:arquidiocese_maceio_app/src/models/Bairro.dart';
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
  Bairro bairroEscolhido = Bairro();

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
    initializer();
    debugPrint("Diocese achada de ${arquidiocese.cidade?.nome}");
  }

  void initializer() {
    for (var distrito in arquidiocese.cidade!.bairro!) {
      for (var igr in distrito.paroquia!.igreja!) {
        listaOriginal.add(igr);
      }
    }
  }

  void procurarPorBairro(String bairro) {
    List<Igreja> listaResultado = [];
    if (bairro.isNotEmpty) {
      listaResultado.clear();
      for (var item in arquidiocese.cidade!.bairro!) {
        if (item.nome!.contains(bairro)) {
          bairroEscolhido = item;
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    procurarPorBairro(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide:
                              BorderSide(width: 3, color: Colors.white)),
                      labelText: "Procurar",
                      hintText: "Procurar",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.white),
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(top: 4.0),
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: darkLightBlue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listaOriginal.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      hoverColor: Colors.grey[400],
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/img/igreja.png"),
                      ),
                      title: Text(listaOriginal[index].homenageado!),
                      subtitle: Text(listaOriginal[index].endereco!),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ParoquiaDetalhe(
                                      paroquia: bairroEscolhido.paroquia!,
                                      igreja: bairroEscolhido
                                          .paroquia!.igreja![index],
                                    )));
                      },
                    );
                  },
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}

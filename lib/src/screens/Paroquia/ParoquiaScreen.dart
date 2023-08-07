import 'dart:convert';

import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/models/Bairro.dart';
import 'package:arquidiocese_maceio_app/src/models/Diocese.dart';
import 'package:arquidiocese_maceio_app/src/models/Igreja.dart';
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
    setState(() {
      debugPrint("Inicializando com ${arquidiocese.cidade!.bairro!.length}");
      for (var distrito in arquidiocese.cidade!.bairro!) {
        for (var igr in distrito.paroquia!.igreja!) {
          listaOriginal.add(igr);
        }
      }
    });
  }

  void procurarPorBairro(String bairro) {
    debugPrint("Procurando por bairro...");
    List<Igreja> listaResultado = [];
    if (bairro.isNotEmpty) {
      listaResultado.clear();
      for (var item in arquidiocese.cidade!.bairro!) {
        if (item.nome!.toLowerCase().contains(bairro.toLowerCase())) {
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
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIconColor: Colors.white,
                      focusColor: Colors.white,
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
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage("assets/img/igreja.png"),
                      ),
                      title: Text(listaOriginal[index].nome!),
                      subtitle: Text(listaOriginal[index].endereco!),
                      onTap: () {
                        var escolha = bairroEscolhido.nome != null
                            ? bairroEscolhido.paroquia!
                            : arquidiocese.cidade!.bairro![index].paroquia!;
                        var igrejaIndex = escolha.igreja!.length;
                        var igrejaEscolhida = bairroEscolhido.nome != null
                            ? igrejaIndex - 1
                            : index;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ParoquiaDetalhe(
                                      paroquia: escolha,
                                      igreja: listaOriginal[igrejaEscolhida],
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

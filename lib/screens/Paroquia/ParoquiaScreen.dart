import 'package:arquidiocese_maceio_app/data/DataModel.dart';
import 'package:arquidiocese_maceio_app/models/Paroquia.dart';
import 'package:arquidiocese_maceio_app/screens/Paroquia/ParoquiaDetalheScreen.dart';
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
      paroquias.forEach((item) {
        if (item.bairroParoquia!.contains(bairro)) {
          listaResultado.add(item);
        }
      });
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Paróquias"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(5, 31, 53, .5),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  procurarPorBairro(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Procurar",
                    hintText: "Procurar",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: listaOriginal.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/img/igreja.png"),
                  ),
                  title: Text(listaOriginal[index].nomeParoquia!),
                  subtitle: Text(listaOriginal[index].bairroParoquia!),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ParoquiaDetalhe(
                                  paroquia: listaOriginal[index],
                                )));
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

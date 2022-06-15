import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';

class MancheteScreen extends StatelessWidget {
  final String? conteudo;
  final String? date;
  final String? categoria;
  final String? titulo;
  final String? subtitulo;
  final String? image;

  const MancheteScreen(
      {Key? key,
      this.categoria,
      this.conteudo,
      this.date,
      this.image,
      this.subtitulo,
      this.titulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRect(
                  child: Image.network(
                    this.image!,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Icon(Icons.tag),
                    Text(
                      this.categoria!,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(Icons.date_range),
                    Text(
                      date!,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(Icons.share),
                    Text("Compartilhar"),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      titulo!,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Html(
                        data: conteudo!,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black),
          )
        ],
      ),
    );
  }
}

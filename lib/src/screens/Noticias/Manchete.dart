import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';

class MancheteScreen extends StatelessWidget {
  final String? conteudo;
  final String? date;
  final String? categoria;
  final String? titulo;
  final String? subtitulo;
  final String? image;
  final String? link;

  const MancheteScreen(
      {Key? key,
      this.categoria,
      this.conteudo,
      this.date,
      this.image,
      this.subtitulo,
      this.titulo,
      this.link})
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRect(
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200.0,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.tag),
                    Text(
                      categoria!,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Icon(Icons.date_range),
                    Text(
                      date!,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                        onTap: () => {
                              Share.share(
                                  'Eu li a matéria: $titulo, no App da Arquidiocese de Maceió $link')
                            },
                        child: Row(
                          children: const [
                            Icon(Icons.share),
                            Text("Compartilhar")
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Text(
                      titulo!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            padding: const EdgeInsets.only(top: 25.0),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
                color: yellowAccenture),
          )
        ],
      ),
    );
  }
}

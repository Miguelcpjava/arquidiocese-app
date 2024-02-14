import 'package:html/dom.dart' as html;

import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/models/PodCast.dart';
import 'package:arquidiocese_maceio_app/src/screens/LoadWidget.dart';
import 'package:arquidiocese_maceio_app/src/screens/Podcast/PodcastDetails.dart';
import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({Key? key}) : super(key: key);

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  late bool loading;
  String? header;
  List<PodCast> podcasts = [];

  @override
  void initState() {
    scrapData();
    super.initState();
    setState(() {
      loading = true;
    });
  }

  Future<void> scrapData() async {
    podcasts.clear();
    debugPrint("Inicializando os podcast da Arquidiocese...");
    var response = await Chaleno().load(ARQUIDIOCESE_PODCAST_URL);
    List<Result>? resultado =
        response!.getElementsByClassName('custom-html-widget');
    html.Document document = html.Document();
    for (int indice = 0; indice < resultado.length; indice++) {
      var texto = resultado[indice].text;
      texto = texto!.replaceAll("[", "");
      texto = texto.replaceAll("]", "");
      var attr = "mp3";
      var htmlNovo = html.Text(texto);

      document.append(htmlNovo);
      String textoHtml = document.outerHtml;
      var regex = RegExp(r'mp3="(.*?)"');

      final regexResult = textoHtml.split("mp3=");
      //regex.firstMatch(textoHtml.toString())?.group(1);
      //debugPrint("=> ${regexResult.length}");
      var dataString = "";
      var tituloString = "";
      for (int i = 0; i < regexResult.length; i++) {
        if (i % 2 == 0) {
          final RegExp titleRegex = RegExp(r'title="(.*?)"');
          final RegExp dateRegex = RegExp(r'songwriter="(.*?)"');
          final Match matchData = dateRegex.firstMatch(regexResult[i])!;
          final Match matchTitle = titleRegex.firstMatch(regexResult[i])!;
          dataString = matchData.group(1)!;
          tituloString = matchTitle.group(1)!;
          //debugPrint("Data: $dataString");
          //debugPrint("Titulo: $tituloString");
        }
        if (i % 2 == 1) {
          //final RegExp dateRegex = RegExp(r'mp3="(.*?)"');
          //final Match matchMp3 = dateRegex.firstMatch(regexResult[i])!;
          var link = regexResult[i].replaceAll("\"", "");
          //debugPrint("Link: $link");
          var pods = extractOf(dataString, link, tituloString);
          if (pods.ano == 2022) {
            podcasts.add(pods);
          }
        }
      }
      //debugPrint("Resultado $indice: ${textoHtml}}");
    }
    setState(() {
      loading = false;
    });
  }

  PodCast extractOf(String data, String url, String title) {
    // int dataIndiceInicial = elements.indexOf("(");
    // int dataIndiceFinal = elements.indexOf(")");
    //String data = elements
    //  .substring(dataIndiceInicial, dataIndiceFinal)
    //.replaceAll("(", "");
    //String titulo = elements.substring(0, dataIndiceInicial);
    var dataArray = data.split(".");
    int? ano = int.tryParse(dataArray.last) ?? 9999;
    PodCast podcast = PodCast(
        url: url, data: data.replaceAll(".", "/"), titulo: title, ano: ano);
    return podcast;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: darkBlue,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35.0, left: 10.0),
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios),
                        color: yellowAccenture),
                  ),
                ),
                const Center(
                  child: Icon(
                    Icons.keyboard_voice_sharp,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Podcasts",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.none)),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: loading == true
                        ? Loading()
                        : RefreshIndicator(
                            onRefresh: scrapData,
                            child: Container(
                              padding: const EdgeInsets.only(top: 4.0),
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0))),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: podcasts.length,
                                itemBuilder:
                                    (BuildContext buildContext, int index) {
                                  return Card(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    margin: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      selectedColor: darkLightBlue,
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PodCastDetailsScreen(
                                              urlAudio: podcasts[index].url!,
                                              programa:
                                                  "Discipulos e Missionários",
                                              episodio: podcasts[index].titulo!,
                                              capa:
                                                  "assets/img/discipulomissionario.jpeg"),
                                        ),
                                      ),
                                      title: Text(
                                        podcasts[index].titulo!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: FONTE_TEXTO_PADRAO),
                                      ),
                                      subtitle: Text(
                                        'Publicado em ${podcasts[index].data!}',
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: FONTE_TEXTO_SUBTITULO),
                                      ),
                                      leading: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Image.asset(
                                            "assets/img/arqbrasao.png"),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider();
                                },
                              ),
                            ),
                          )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

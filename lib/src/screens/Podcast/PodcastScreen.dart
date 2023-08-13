import 'dart:ffi';

import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/models/PodCast.dart';
import 'package:arquidiocese_maceio_app/src/screens/LoadWidget.dart';
import 'package:arquidiocese_maceio_app/src/shared/UrlUtil.dart';
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
    var response = await Chaleno().load(ARQUIDIOCESE_PODCAST_URL);
    List<Result>? resultado = response?.getElementsByClassName('track');
    for (var index in resultado!) {
      var link = index.querySelector("a")!.text;
      var pods = extractOf(index.text!, link!);
      if (pods.ano == 2022) {
        podcasts.add(pods);
      }
    }
    setState(() {
      loading = false;
    });
  }

  PodCast extractOf(String elements, String url) {
    int dataIndiceInicial = elements.indexOf("(");
    int dataIndiceFinal = elements.indexOf(")");
    String data = elements
        .substring(dataIndiceInicial, dataIndiceFinal)
        .replaceAll("(", "");
    String titulo = elements.substring(0, dataIndiceInicial);
    var dataArray = data.split(".");
    int? ano = int.tryParse(dataArray.last) ?? 9999;
    PodCast podcast = PodCast(
        url: url, data: data.replaceAll(".", "/"), titulo: titulo, ano: ano);
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
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: podcasts.length,
                                  itemBuilder:
                                      (BuildContext buildContext, int index) {
                                    return Card(
                                      elevation: 4,
                                      margin: EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        dense: true,
                                        selectedColor: darkLightBlue,
                                        onTap: () => UrlUtils()
                                            .getLaunchUrl(podcasts[index].url),
                                        title: podcasts[index].titulo!.length >
                                                100
                                            ? Text(podcasts[index].titulo!,
                                                overflow: TextOverflow.ellipsis)
                                            : Text(
                                                podcasts[index].titulo!,
                                              ),
                                        subtitle: Text(
                                            'Publicado em ${podcasts[index].data!}'),
                                        leading: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Image.asset(
                                              "assets/img/arqbrasao.png"),
                                        ),
                                      ),
                                    );
                                  }),
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

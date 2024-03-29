import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/models/Noticias.dart';
import 'package:arquidiocese_maceio_app/src/screens/LoadWidget.dart';
import 'package:arquidiocese_maceio_app/src/screens/Noticias/Manchete.dart';
import 'package:arquidiocese_maceio_app/src/services/NewsService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webfeed/webfeed.dart';

class UltimasNoticiasScreen extends StatefulWidget {
  const UltimasNoticiasScreen({Key? key}) : super(key: key);

  @override
  State<UltimasNoticiasScreen> createState() => _UltimasNoticiasScreenState();
}

class _UltimasNoticiasScreenState extends State<UltimasNoticiasScreen> {
  final List<Noticia> _noticias = [];
  late bool loading;
  NewsService newsService = NewsService();

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });

    getListaDeNoticias();
  }

  Future<void> getListaDeNoticias() async {
    newsService.getFeedNoticiasArquidiocese().then((value) {
      setState(() {
        adicionarNovaNoticias(value!.items, true);
        loading = false;
      });
    });
  }

  adicionarNovaNoticias(items, bool limit) {
    bool numeroMaximoNoticia = false;

    for (RssItem item in items) {
      numeroMaximoNoticia = _noticias.length > 21 ? false : true;
      Noticia _noticia = Noticia(
          title: item.title,
          image: item.content?.images.last,
          date: item.pubDate,
          content: item.content?.value,
          link: item.link,
          category: item.categories?.first.value);

      if (limit && numeroMaximoNoticia) {
        _noticias.add(_noticia);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: darkBlue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
            ),
            child: Column(
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
                    Icons.newspaper,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Últimas Noticias",
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
                          onRefresh: getListaDeNoticias,
                          child: Container(
                            height: size.height,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0))),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _noticias.length,
                                itemBuilder:
                                    (BuildContext buildContext, int index) {
                                  return Container(
                                    child: ListTile(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MancheteScreen(
                                            link: _noticias[index].link,
                                            titulo: _noticias[index].title,
                                            date: DateFormat("dd/MM/yyyy")
                                                .format(_noticias[index].date),
                                            image: _noticias[index]
                                                .image
                                                .toString(),
                                            categoria:
                                                _noticias[index].category,
                                            subtitulo:
                                                _noticias[index].subtitle,
                                            conteudo: _noticias[index].content,
                                          ),
                                        ),
                                      ),
                                      title: Text(_noticias[index].title!),
                                      subtitle: Text('Publicado em ' +
                                          DateFormat("dd/MM/yyyy")
                                              .format(_noticias[index].date)),
                                      leading: Container(
                                        width: 90.0,
                                        height: 90.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                _noticias[index].image != null
                                                    ? NetworkImage(
                                                        _noticias[index].image)
                                                    : const NetworkImage(
                                                        "assets/img/ImageNA.png",
                                                      ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

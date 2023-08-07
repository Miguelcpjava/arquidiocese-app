import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/data/DataMenu.dart';
import 'package:arquidiocese_maceio_app/src/models/Noticias.dart';
import 'package:arquidiocese_maceio_app/src/screens/LoadWidget.dart';
import 'package:arquidiocese_maceio_app/src/screens/Noticias/Manchete.dart';
import 'package:arquidiocese_maceio_app/src/services/NewsService.dart';
import 'package:arquidiocese_maceio_app/src/widgets/CardsMenu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webfeed/webfeed.dart';

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({Key? key}) : super(key: key);

  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}

//https://stackoverflow.com/questions/60978347/stack-an-image-in-two-widgets-flutter
class _NoticiasScreenState extends State<NoticiasScreen> {
  final List<Noticia> _noticias = [];
  NewsService newsService = NewsService();
  RssFeed _rssFeed = RssFeed(); // RSS Feed Object
  var inputFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
  late bool loading;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });

    if (_noticias.isNotEmpty) {
      _noticias.clear();
    }
    getListaDeNoticias();
  }

  Future<void> getListaDeNoticias() async {
    newsService.getFeedNoticiasArquidiocese().then((value) {
      updateFeed(value);
    });
  }

  updateFeed(feed) {
    setState(() {
      _rssFeed = feed;
      adicionarNovaNoticias(_rssFeed.items, true);
      loading = false;
    });
  }

  adicionarNovaNoticias(items, bool limit) {
    bool numeroMaximoNoticia = false;

    for (RssItem item in items) {
      numeroMaximoNoticia = _noticias.length > 6 ? false : true;
      int index = item.content!.images.length;
      Noticia _noticia = Noticia(
          title: item.title,
          image: index > 0 ? item.content?.images.last : "sem-imagem",
          date: item.pubDate,
          content: item.content?.value,
          link: item.link,
          category: item.categories?.first.value);

      if (limit && numeroMaximoNoticia) {
        _noticias.add(_noticia);
        //slice para 5 itens apenas
      }
    }
  }

  void activateSnackBar(String title, BuildContext context) {
    String message = "O menu $title está em desenvolvimento!";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Text(
          "O menu $title está em desenvolvimento!",
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        duration: const Duration(milliseconds: 700),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        backgroundColor: darkBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var sized = MediaQuery.of(context).size;
    var qtdCardNews = sized.height * 0.01;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: darkBlue,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 55,
                ),
                Center(
                  child: Image.asset(
                    "assets/img/arqbrasao.png",
                    alignment: Alignment.centerRight,
                    width: 110,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Arquidiocese de Maceió",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.none)),
                SizedBox(
                  height: 118,
                  width: sized.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: menus.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              menus[index].widget.runtimeType.toString() !=
                                      "Container"
                                  ? GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                menus[index].widget),
                                      ),
                                      child: CardsMenu(
                                          height: menus[index].height,
                                          icon: menus[index].icon,
                                          text: menus[index].title),
                                    )
                                  : GestureDetector(
                                      onTap: () => activateSnackBar(
                                          menus[index].title, context),
                                      child: CardsMenu(
                                          height: menus[index].height,
                                          icon: menus[index].icon,
                                          text: menus[index].title),
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: loading == true
                      ? Loading()
                      : RefreshIndicator(
                          onRefresh: getListaDeNoticias,
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
                                itemCount: 6,
                                itemBuilder:
                                    (BuildContext buildContext, int index) {
                                  return ListTile(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MancheteScreen(
                                          link: _noticias[index].link,
                                          titulo: _noticias[index].title,
                                          date: DateFormat("dd/MM/yyyy")
                                              .format(_noticias[index].date),
                                          image:
                                              _noticias[index].image.toString(),
                                          categoria: _noticias[index].category,
                                          subtitulo: _noticias[index].subtitle,
                                          conteudo: _noticias[index].content,
                                        ),
                                      ),
                                    ),
                                    title: Text(_noticias[index].title!),
                                    subtitle: Text('Publicado em ' +
                                        DateFormat("dd/MM/yyyy")
                                            .format(_noticias[index].date)),
                                    leading: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: _noticias[index].image !=
                                                  "sem-imagem"
                                              ? NetworkImage(_noticias[index]
                                                  .image
                                                  .toString())
                                              : const AssetImage(
                                                      "assets/img/ImageNA.png")
                                                  as ImageProvider,
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

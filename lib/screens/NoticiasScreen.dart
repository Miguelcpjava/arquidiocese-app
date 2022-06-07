import 'dart:convert';

import 'package:arquidiocese_maceio_app/data/Constants.dart';
import 'package:arquidiocese_maceio_app/data/DataMenu.dart';
import 'package:arquidiocese_maceio_app/models/Noticias.dart';
import 'package:arquidiocese_maceio_app/services/NewsService.dart';
import 'package:arquidiocese_maceio_app/widgets/CardsMenu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({Key? key}) : super(key: key);

  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}

//https://stackoverflow.com/questions/60978347/stack-an-image-in-two-widgets-flutter
class _NoticiasScreenState extends State<NoticiasScreen> {
  List<Noticia> _noticias = [];
  NewsService newsService = new NewsService();
  RssFeed _rssFeed = new RssFeed(); // RSS Feed Object
  var inputFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

  @override
  void initState() {
    print("Initializer...");
    super.initState();
    if (_noticias.length > 0) _noticias.clear();
    getListaDeNoticias();

    print(_noticias.length);
  }

  getListaDeNoticias() {
    newsService.getFeedNoticiasArquidiocese().then((value) {
      updateFeed(value);
    });
  }

  updateFeed(feed) {
    setState(() {
      _rssFeed = feed;
      adicionarNovaNoticias(_rssFeed.items, true);
    });
  }

  adicionarNovaNoticias(items, bool limit) {
    bool numeroMaximoNoticia = false;

    for (RssItem item in items) {
      numeroMaximoNoticia = _noticias.length > 5 ? false : true;
      Noticia _noticia = Noticia(
          title: item.title,
          image: item.content?.images.last,
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

  Loading(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(darkBlue),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: darkBlue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 55,
                ),
                Center(
                  child: Image.asset(
                    "assets/img/arqbrasao.png",
                    alignment: Alignment.centerRight,
                    width: 120,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Arquidiocese de Maceió",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.none)),
                SizedBox(
                  height: 115,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: menus.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CardsMenu(
                              height: menus[index].height,
                              icon: menus[index].icon,
                              text: menus[index].title,
                              clazz: menus[index].widget),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (BuildContext buildContext, int index) {
                          if (_noticias.length == 0) {
                            return Container(
                                child: Center(child: Loading(buildContext)));
                          } else {
                            return Container(
                              child: ListTile(
                                onTap: () => _launchUrl(_noticias[index].link),
                                title: Text(_noticias[index].title!),
                                subtitle: Text('Publicado em ' +
                                    DateFormat("dd/MM/yyyy")
                                        .format(_noticias[index].date)),
                                leading: Container(
                                  width: 70.0,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _noticias[index].image != null
                                          ? NetworkImage(_noticias[index].image)
                                          : NetworkImage(
                                              "assets/img/ImageNA.png",
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String? link) async {
    Uri url = Uri.parse(link!);
    if (!await launchUrl(url)) throw 'Não foi possivel acessar $url';
  }
}

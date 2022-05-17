import 'dart:convert';

import 'package:arquidiocese_maceio_app/data/DataMenu.dart';
import 'package:arquidiocese_maceio_app/models/Noticias.dart';
import 'package:arquidiocese_maceio_app/services/NewsService.dart';
import 'package:arquidiocese_maceio_app/widgets/CardsMenu.dart';
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
      adicionarNovaNoticias(_rssFeed.items);
    });
  }

  adicionarNovaNoticias(items) {
    for (RssItem item in items) {
      Noticia _noticia = Noticia(
          title: item.title,
          image: item.content?.images.last,
          date: item.pubDate,
          content: item.content?.value,
          category: item.categories?.first.value);
      _noticias.add(_noticia);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[900],
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
                              text: menus[index].title),
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
                      itemCount: _noticias.length,
                      itemBuilder: (BuildContext buildContext, int index) {
                        return Container(
                          child: ListTile(
                            title: Text(_noticias[index].title!),
                            subtitle: Text(DateFormat("dd/MM/yyyy hh:mm:ss")
                                .format(_noticias[index].date)),
                            leading: _noticias[index].image != null
                                ? Image.network(_noticias[index].image)
                                : Image.asset("assets/img/ImageNA.png"),
                          ),
                        );
                      },
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

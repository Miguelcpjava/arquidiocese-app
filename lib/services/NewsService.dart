import 'dart:convert';

import 'package:arquidiocese_maceio_app/models/Noticias.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class NewsService {
  String ARQUIDOCESE_RSS_FEED_URL =
      "https://www.centenarioarqmaceio.com.br/feed";
  late List<Noticia> noticias;

  Future<RssFeed?> getFeedNoticiasArquidiocese() async {
    print("Open Rss Feed Arquidiocese...");
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(ARQUIDOCESE_RSS_FEED_URL));
      return RssFeed.parse(utf8.decode(response.bodyBytes));
    } catch (e) {
      print(e);
    }
    return null;
  }
}

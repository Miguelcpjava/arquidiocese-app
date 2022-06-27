import 'dart:convert';
import 'dart:developer';

import 'package:arquidiocese_maceio_app/src/widgets/CustomAlertDialog.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';

class NewsService {
  // ignore: constant_identifier_names
  static const String ARQUIDOCESE_RSS_FEED_URL =
      "https://www.centenarioarqmaceio.com.br/feed";

  Future<RssFeed?> getFeedNoticiasArquidiocese() async {
    debugPrint("Open Rss Feed Arquidiocese...");
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(ARQUIDOCESE_RSS_FEED_URL));
      return RssFeed.parse(utf8.decode(response.bodyBytes));
    } catch (e) {
      CustomAlertDialog("Erro ao tentar comunicação!", e.toString());
      log(e.toString());
    }
    return null;
  }

  void getLaunchUrl(String? link) async {
    Uri url = Uri.parse(link!);
    if (!await launchUrl(url)) throw 'Não foi possivel acessar $url';
  }
}

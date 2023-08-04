import 'package:url_launcher/url_launcher.dart';

class UrlUtils {
  void getLaunchUrl(String? link) async {
    Uri url = Uri.parse(link!);
    if (!await launchUrl(url)) throw 'Não foi possivel acessar $url';
  }
}

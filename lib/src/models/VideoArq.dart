import 'package:arquidiocese_maceio_app/src/shared/Figura.dart';

class VideoArq {
  Figuras? thumbnail;
  String? id;
  DateTime? publishedAt;
  String? channelId;
  String? channelUrl;
  String title;
  String? description;
  String url;
  String? duration;

  VideoArq(
      {this.channelId,
      this.thumbnail,
      this.id,
      this.publishedAt,
      this.channelUrl,
      required this.title,
      this.description,
      required this.url,
      this.duration});
}

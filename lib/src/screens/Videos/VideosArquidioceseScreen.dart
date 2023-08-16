import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/models/VideoArq.dart';
import 'package:arquidiocese_maceio_app/src/screens/LoadWidget.dart';
import 'package:arquidiocese_maceio_app/src/services/DataTimeService.dart';
import 'package:arquidiocese_maceio_app/src/shared/Figura.dart';
import 'package:arquidiocese_maceio_app/src/shared/FiguraRef.dart';
import 'package:arquidiocese_maceio_app/src/shared/UrlUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_api/youtube_api.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late bool loading;
  static const String _youtube = "Teste";
  YoutubeAPI ytApi = YoutubeAPI(_youtube, maxResults: 20, type: "channel");
  List<YouTubeVideo> videoResult = [];
  List<VideoArq> videosArquidiocese = [];
  DataTimeFormarter formatador = DataTimeFormarter();

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    getVideosDaArquidiocese();
  }

  Future<void> getVideosDaArquidiocese() async {
    videoResult = await ytApi.search(ARQUIDIOCESE_CHANNEL);
    for (var video in videoResult) {
      videosArquidiocese.add(VideoArq(
          id: video.id,
          title: video.title,
          url: video.url,
          channelId: video.channelId,
          channelUrl: video.channelUrl,
          description: video.description,
          duration: video.duration,
          publishedAt: formatador.setStringDataParaDataTime(video.publishedAt!),
          thumbnail: Figuras(
              high: FiguraRef(
                  height: video.thumbnail.high.height,
                  width: video.thumbnail.high.width,
                  url: video.thumbnail.high.url),
              medium: FiguraRef(
                  height: video.thumbnail.medium.height,
                  width: video.thumbnail.medium.width,
                  url: video.thumbnail.medium.url),
              small: FiguraRef(
                  height: video.thumbnail.small.height,
                  width: video.thumbnail.small.width,
                  url: video.thumbnail.small.url))));
    }
    videosArquidiocese
        .sort(((a, b) => b.publishedAt!.compareTo(a.publishedAt!)));

//    videoResult = await ytApi.nextPage();
    setState(() {
      loading = false;
    });
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
                    padding: const EdgeInsets.only(top: 25.0),
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios),
                        color: yellowAccenture),
                  ),
                ),
                const Center(
                  child: Icon(
                    Icons.video_library_outlined,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Videos",
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
                          onRefresh: getVideosDaArquidiocese,
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
                                itemCount: videosArquidiocese.length,
                                itemBuilder:
                                    (BuildContext buildContext, int index) {
                                  return ListTile(
                                    onTap: () => UrlUtils().getLaunchUrl(
                                        videosArquidiocese[index].url),
                                    title: videosArquidiocese[index]
                                                .title
                                                .length >
                                            100
                                        ? Text(videosArquidiocese[index].title,
                                            overflow: TextOverflow.ellipsis)
                                        : Text(
                                            videosArquidiocese[index].title,
                                          ),
                                    subtitle: Text(
                                        'Publicado em ${formatador.getTransformadorStringParaData(videosArquidiocese[index].publishedAt!)}'),
                                    leading: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: videosArquidiocese[index]
                                              .thumbnail!
                                              .small
                                              .url!
                                              .isNotEmpty
                                          ? Image.network(
                                              videosArquidiocese[index]
                                                      .thumbnail!
                                                      .small
                                                      .url ??
                                                  '',
                                              width: 120.0,
                                            )
                                          : Image.asset(
                                              "assets/img/ImageNA.png"),
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

import 'package:arquidiocese_maceio_app/src/data/Constants.dart';
import 'package:arquidiocese_maceio_app/src/screens/LoadWidget.dart';
import 'package:arquidiocese_maceio_app/src/services/DataTimeService.dart';
import 'package:arquidiocese_maceio_app/src/share/UrlUtil.dart';
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
  static const String _youtube = "AIzaSyAdlklWyWoBhwoEbCM6nsMtf5kJ4qy5g5E";
  YoutubeAPI ytApi = YoutubeAPI(_youtube, maxResults: 15, type: "channel");
  List<YouTubeVideo> videoResult = [];
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
    videoResult = await ytApi.search(
      ARQUIDIOCESE_CHANNEL,
      order: 'relevance',
      videoDuration: 'any',
    );
    debugPrint("Acessando Video de: ${videoResult.first.channelTitle}");
    videoResult = await ytApi.nextPage();
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
                                itemCount: videoResult.length,
                                itemBuilder:
                                    (BuildContext buildContext, int index) {
                                  return ListTile(
                                    onTap: () => UrlUtils()
                                        .getLaunchUrl(videoResult[index].url),
                                    title: videoResult[index].title.length > 100
                                        ? Text(videoResult[index].title,
                                            overflow: TextOverflow.ellipsis)
                                        : Text(
                                            videoResult[index].title!,
                                          ),
                                    subtitle: Text(
                                        'Publicado em ${formatador.getTransformerData(videoResult[index].publishedAt!)}'),
                                    leading: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: videoResult[index]
                                              .thumbnail
                                              .small
                                              .url!
                                              .isNotEmpty
                                          ? Image.network(
                                              videoResult[index]
                                                      .thumbnail
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

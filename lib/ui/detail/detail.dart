import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:itsallwidgets_podcast/data/rss_response.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail_store.dart';

class PodCastDetail extends StatefulWidget {
  final Item item;
  final RssResponse feed;

  PodCastDetail(this.item, this.feed);

  @override
  State<PodCastDetail> createState() => _PodCastDetailState();
}

class _PodCastDetailState extends State<PodCastDetail> {
  late final DetailStore store;
  @override
  void initState() {
    super.initState();
    store = DetailStore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.item.title!,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/app_icon.png'),
                      image: NetworkImage(
                        'https://itsallwidgets.com/images/podcast.jpg',
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.all(16),
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.item.title!,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Colors.blue,
                height: 3,
                width: 50,
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              ),
              PlayerControllerWidget(
                store: store,
                item: widget.item,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Linkify(
                  onOpen: (link) async {
                    if (await canLaunch(link.url)) {
                      await launch(link.url);
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                  text: widget.item.contentHtml!,

                  // linkTypes: [LinkType.url],
                  linkStyle:
                      const TextStyle(fontSize: 16, color: Colors.indigo),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerControllerWidget extends StatelessWidget {
  final DetailStore? store;
  final Item? item;

  const PlayerControllerWidget({Key? key, this.store, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Observer(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  store!.isAudioLoading
                      ? CircularProgressIndicator()
                      : IconButton(
                          onPressed: store!.isPlaying
                              ? () => store!.pause()
                              : () => store!.play(item!.guid!),
                          iconSize: 48,
                          icon: store!.isPlaying
                              ? const Icon(Icons.pause)
                              : const Icon(Icons.play_arrow),
                          color: Colors.blue,
                        ),
                  Visibility(
                    visible: store!.isPlaying || store!.isPaused,
                    child: IconButton(
                      onPressed: store!.isPlaying || store!.isPaused
                          ? () => store!.stop()
                          : null,
                      iconSize: 48,
                      icon: const Icon(Icons.stop),
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () => store!.mute(!store!.isMuted),
                    iconSize: 48,
                    icon: store!.isMuted
                        ? const Icon(Icons.volume_off)
                        : const Icon(Icons.volume_up),
                    color: Colors.blue,
                  ),
                ],
              ),
              Visibility(
                visible: store!.duration == null,
                child: Slider(
                  value: store!.position?.inMilliseconds.toDouble() ?? 0,
                  onChanged: (double value) =>
                      store!.audioPlayer.seek((value / 1000).roundToDouble()),
                  min: 0,
                  max: store!.duration!.inMilliseconds.toDouble(),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: [
                        CircularProgressIndicator(
                          value: 1,
                          valueColor: AlwaysStoppedAnimation(Colors.grey[300]),
                        ),
                        CircularProgressIndicator(
                          value: store!.position != null &&
                                  store!.position!.inMilliseconds > 0
                              ? (store!.position?.inMilliseconds.toDouble() ??
                                      0) /
                                  (store!.duration?.inMilliseconds.toDouble() ??
                                      0)
                              : 0,
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    store!.position != null
                        ? "${store!.positionText ?? ''} / ${store!.durationText ?? ''}"
                        : store!.duration != null
                            ? store!.durationText
                            : '',
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsallwidgets_podcast/data/rss_response.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verbal_expressions/verbal_expressions.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

enum PlayerState { stopped, playing, paused }

class PodCastDetail extends StatefulWidget {
  final Items item;
  final Feed feed;

  PodCastDetail(this.item, this.feed);

  @override
  PodCastDetailState createState() {
    return PodCastDetailState();
  }
}

class PodCastDetailState extends State<PodCastDetail> {
  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;

  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  Future play() async {
    await audioPlayer.play(widget.item.guid);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
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
                    tag: widget.item.title,
                    child: Image.network(widget.feed.image),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.item.title,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              buildBlueDivider(),
              _buildPlayer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.item.description,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: displayUrls(widget.item.description),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildBlueDivider() {
    return Container(
      color: Colors.blue,
      height: 3,
      width: 50,
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    );
  }

  Widget _buildPlayer() => Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                  onPressed: isPlaying ? null : () => play(),
                  iconSize: 48.0,
                  icon: Icon(Icons.play_arrow),
                  color: Colors.blue),
              IconButton(
                  onPressed: isPlaying ? () => pause() : null,
                  iconSize: 48.0,
                  icon: Icon(Icons.pause),
                  color: Colors.blue),
              IconButton(
                  onPressed: isPlaying || isPaused ? () => stop() : null,
                  iconSize: 48.0,
                  icon: Icon(Icons.stop),
                  color: Colors.blue),
              IconButton(
                  onPressed: () => mute(!isMuted),
                  iconSize: 48.0,
                  icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
                  color: Colors.blue),
            ]),
            duration == null
                ? Container()
                : Slider(
                    value: position?.inMilliseconds?.toDouble() ?? 0.0,
                    onChanged: (double value) =>
                        audioPlayer.seek((value / 1000).roundToDouble()),
                    min: 0.0,
                    max: duration.inMilliseconds.toDouble()),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Stack(
                    children: [
                      CircularProgressIndicator(
                          value: 1.0,
                          valueColor: AlwaysStoppedAnimation(Colors.grey[300])),
                      CircularProgressIndicator(
                        value: position != null && position.inMilliseconds > 0
                            ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
                                (duration?.inMilliseconds?.toDouble() ?? 0.0)
                            : 0.0,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ],
                  ),
                ),
                Text(
                  position != null
                      ? "${positionText ?? ''} / ${durationText ?? ''}"
                      : duration != null ? durationText : '',
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
          ],
        ),
      );

  displayUrls(String description) {
    var regex = VerbalExpression()
      ..startOfLine()
      ..then("https")
      ..then("://")
      ..anythingBut(" ")
      ..endOfLine();

    // Create an example URL
    String url = description;

    // Use VerbalExpression's hasMatch() method to test if the entire string matches the regex
    regex.hasMatch(url); //True

    regex.toString();

    final urlRegex = RegExp('https\:\/\/(?:[^\#,]*)', multiLine: true);
    var urlToDisplay =
        (urlRegex.allMatches(description).map((m) => m.group(0)));

    for (var url in urlToDisplay) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Linkify(
          onOpen: (url) async {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          text: '\n$url\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blue,
          ),
        ),
      );
    }
  }
}

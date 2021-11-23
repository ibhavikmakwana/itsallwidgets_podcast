import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:mobx/mobx.dart';

part 'detail_store.g.dart';

class DetailStore = _DetailStore with _$DetailStore;

abstract class _DetailStore with Store {
  _DetailStore() {
    initPlayer();
  }

  late AudioPlayer audioPlayer;
  late StreamSubscription _positionSubscription;
  late StreamSubscription _audioPlayerStateSubscription;

  @observable
  Duration? duration;

  @observable
  PlayerState playerState = PlayerState.stopped;

  @observable
  bool isAudioLoading = false;

  @observable
  Duration? position;

  @observable
  bool isMuted = false;

  @computed
  bool get isPlaying => playerState == PlayerState.playing;

  @computed
  bool get isPaused => playerState == PlayerState.paused;

  @computed
  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  @computed
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  @action
  play(String guid) async {
    isAudioLoading = true;
    await audioPlayer.play(guid);
    isAudioLoading = false;
    playerState = PlayerState.playing;
  }

  @action
  Future pause() async {
    await audioPlayer.pause();
    playerState = PlayerState.paused;
  }

  @action
  Future stop() async {
    await audioPlayer.stop();
    playerState = PlayerState.stopped;
    position = Duration();
  }

  @action
  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    isMuted = muted;
  }

  void initPlayer() {
    audioPlayer = AudioPlayer();
    duration = Duration();
    _positionSubscription =
        audioPlayer.onAudioPositionChanged.listen((pos) => position = pos);
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == AudioPlayerState.PLAYING) {
        duration = audioPlayer.duration;
      } else if (state == AudioPlayerState.STOPPED) {
        playerState = PlayerState.stopped;
        position = duration;
      }
    }, onError: (msg) {
      playerState = PlayerState.stopped;
      duration = Duration(seconds: 0);
      position = Duration(seconds: 0);
    });
  }

  dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
  }
}

enum PlayerState { stopped, playing, paused }

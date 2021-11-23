// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailStore on _DetailStore, Store {
  Computed<bool>? _$isPlayingComputed;

  @override
  bool get isPlaying => (_$isPlayingComputed ??=
          Computed<bool>(() => super.isPlaying, name: '_DetailStore.isPlaying'))
      .value;
  Computed<bool>? _$isPausedComputed;

  @override
  bool get isPaused => (_$isPausedComputed ??=
          Computed<bool>(() => super.isPaused, name: '_DetailStore.isPaused'))
      .value;
  Computed<dynamic>? _$durationTextComputed;

  @override
  dynamic get durationText =>
      (_$durationTextComputed ??= Computed<dynamic>(() => super.durationText,
              name: '_DetailStore.durationText'))
          .value;
  Computed<dynamic>? _$positionTextComputed;

  @override
  dynamic get positionText =>
      (_$positionTextComputed ??= Computed<dynamic>(() => super.positionText,
              name: '_DetailStore.positionText'))
          .value;

  final _$durationAtom = Atom(name: '_DetailStore.duration');

  @override
  Duration? get duration {
    _$durationAtom.reportRead();
    return super.duration;
  }

  @override
  set duration(Duration? value) {
    _$durationAtom.reportWrite(value, super.duration, () {
      super.duration = value;
    });
  }

  final _$playerStateAtom = Atom(name: '_DetailStore.playerState');

  @override
  PlayerState get playerState {
    _$playerStateAtom.reportRead();
    return super.playerState;
  }

  @override
  set playerState(PlayerState value) {
    _$playerStateAtom.reportWrite(value, super.playerState, () {
      super.playerState = value;
    });
  }

  final _$isAudioLoadingAtom = Atom(name: '_DetailStore.isAudioLoading');

  @override
  bool get isAudioLoading {
    _$isAudioLoadingAtom.reportRead();
    return super.isAudioLoading;
  }

  @override
  set isAudioLoading(bool value) {
    _$isAudioLoadingAtom.reportWrite(value, super.isAudioLoading, () {
      super.isAudioLoading = value;
    });
  }

  final _$positionAtom = Atom(name: '_DetailStore.position');

  @override
  Duration? get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Duration? value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  final _$isMutedAtom = Atom(name: '_DetailStore.isMuted');

  @override
  bool get isMuted {
    _$isMutedAtom.reportRead();
    return super.isMuted;
  }

  @override
  set isMuted(bool value) {
    _$isMutedAtom.reportWrite(value, super.isMuted, () {
      super.isMuted = value;
    });
  }

  final _$playAsyncAction = AsyncAction('_DetailStore.play');

  @override
  Future play(String guid) {
    return _$playAsyncAction.run(() => super.play(guid));
  }

  final _$pauseAsyncAction = AsyncAction('_DetailStore.pause');

  @override
  Future<dynamic> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  final _$stopAsyncAction = AsyncAction('_DetailStore.stop');

  @override
  Future<dynamic> stop() {
    return _$stopAsyncAction.run(() => super.stop());
  }

  final _$muteAsyncAction = AsyncAction('_DetailStore.mute');

  @override
  Future<dynamic> mute(bool muted) {
    return _$muteAsyncAction.run(() => super.mute(muted));
  }

  @override
  String toString() {
    return '''
duration: ${duration},
playerState: ${playerState},
isAudioLoading: ${isAudioLoading},
position: ${position},
isMuted: ${isMuted},
isPlaying: ${isPlaying},
isPaused: ${isPaused},
durationText: ${durationText},
positionText: ${positionText}
    ''';
  }
}

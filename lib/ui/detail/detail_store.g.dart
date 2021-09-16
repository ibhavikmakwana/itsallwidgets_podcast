// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$DetailStore on _DetailStore, Store {
  Computed<dynamic>? _$durationTextComputed;

  @override
  dynamic get durationText =>
      (_$durationTextComputed ??= Computed<dynamic>(() => super.durationText))
          .value;
  Computed<dynamic>? _$positionTextComputed;

  @override
  dynamic get positionText =>
      (_$positionTextComputed ??= Computed<dynamic>(() => super.positionText))
          .value;

  final _$durationAtom = Atom(name: '_DetailStore.duration');

  @override
  Duration? get duration {
    _$durationAtom.context.enforceReadPolicy(_$durationAtom);
    _$durationAtom.reportObserved();
    return super.duration;
  }

  @override
  set duration(Duration? value) {
    _$durationAtom.context.conditionallyRunInAction(() {
      super.duration = value;
      _$durationAtom.reportChanged();
    }, _$durationAtom, name: '${_$durationAtom.name}_set');
  }

  final _$playerStateAtom = Atom(name: '_DetailStore.playerState');

  @override
  PlayerState get playerState {
    _$playerStateAtom.context.enforceReadPolicy(_$playerStateAtom);
    _$playerStateAtom.reportObserved();
    return super.playerState;
  }

  @override
  set playerState(PlayerState value) {
    _$playerStateAtom.context.conditionallyRunInAction(() {
      super.playerState = value;
      _$playerStateAtom.reportChanged();
    }, _$playerStateAtom, name: '${_$playerStateAtom.name}_set');
  }

  final _$isAudioLoadingAtom = Atom(name: '_DetailStore.isAudioLoading');

  @override
  bool get isAudioLoading {
    _$isAudioLoadingAtom.context.enforceReadPolicy(_$isAudioLoadingAtom);
    _$isAudioLoadingAtom.reportObserved();
    return super.isAudioLoading;
  }

  @override
  set isAudioLoading(bool value) {
    _$isAudioLoadingAtom.context.conditionallyRunInAction(() {
      super.isAudioLoading = value;
      _$isAudioLoadingAtom.reportChanged();
    }, _$isAudioLoadingAtom, name: '${_$isAudioLoadingAtom.name}_set');
  }

  final _$positionAtom = Atom(name: '_DetailStore.position');

  @override
  Duration? get position {
    _$positionAtom.context.enforceReadPolicy(_$positionAtom);
    _$positionAtom.reportObserved();
    return super.position;
  }

  @override
  set position(Duration? value) {
    _$positionAtom.context.conditionallyRunInAction(() {
      super.position = value;
      _$positionAtom.reportChanged();
    }, _$positionAtom, name: '${_$positionAtom.name}_set');
  }

  final _$isMutedAtom = Atom(name: '_DetailStore.isMuted');

  @override
  bool get isMuted {
    _$isMutedAtom.context.enforceReadPolicy(_$isMutedAtom);
    _$isMutedAtom.reportObserved();
    return super.isMuted;
  }

  @override
  set isMuted(bool value) {
    _$isMutedAtom.context.conditionallyRunInAction(() {
      super.isMuted = value;
      _$isMutedAtom.reportChanged();
    }, _$isMutedAtom, name: '${_$isMutedAtom.name}_set');
  }

  final _$playAsyncAction = AsyncAction('play');

  @override
  Future play(String? guid) {
    return _$playAsyncAction.run(() => super.play(guid!));
  }

  final _$pauseAsyncAction = AsyncAction('pause');

  @override
  Future<dynamic> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  final _$stopAsyncAction = AsyncAction('stop');

  @override
  Future<dynamic> stop() {
    return _$stopAsyncAction.run(() => super.stop());
  }

  final _$muteAsyncAction = AsyncAction('mute');

  @override
  Future<dynamic> mute(bool muted) {
    return _$muteAsyncAction.run(() => super.mute(muted));
  }
}

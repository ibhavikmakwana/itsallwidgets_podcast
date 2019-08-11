// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$ListStore on _ListStore, Store {
  final _$responseAtom = Atom(name: '_ListStore.response');

  @override
  BaseResponse<RssResponse> get response {
    _$responseAtom.context.enforceReadPolicy(_$responseAtom);
    _$responseAtom.reportObserved();
    return super.response;
  }

  @override
  set response(BaseResponse<RssResponse> value) {
    _$responseAtom.context.conditionallyRunInAction(() {
      super.response = value;
      _$responseAtom.reportChanged();
    }, _$responseAtom, name: '${_$responseAtom.name}_set');
  }

  final _$fetchAllPodCastAsyncAction = AsyncAction('fetchAllPodCast');

  @override
  Future<BaseResponse> fetchAllPodCast() {
    return _$fetchAllPodCastAsyncAction.run(() => super.fetchAllPodCast());
  }
}

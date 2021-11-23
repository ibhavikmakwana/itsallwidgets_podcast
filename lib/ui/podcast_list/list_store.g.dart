// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListStore on _ListStore, Store {
  final _$responseAtom = Atom(name: '_ListStore.response');

  @override
  BaseResponse<RssResponse>? get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(BaseResponse<RssResponse>? value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  final _$fetchAllPodCastAsyncAction =
      AsyncAction('_ListStore.fetchAllPodCast');

  @override
  Future<BaseResponse<dynamic>?> fetchAllPodCast() {
    return _$fetchAllPodCastAsyncAction.run(() => super.fetchAllPodCast());
  }

  @override
  String toString() {
    return '''
response: ${response}
    ''';
  }
}

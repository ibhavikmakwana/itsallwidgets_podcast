import 'dart:developer';

import 'package:itsallwidgets_podcast/data/repository.dart';
import 'package:itsallwidgets_podcast/data/rss_response.dart';
import 'package:itsallwidgets_podcast/network/base_response.dart';
import 'package:mobx/mobx.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  _ListStore() {
    fetchAllPodCast();
  }

  @observable
  BaseResponse<RssResponse>? response;

  @action
  Future<BaseResponse?> fetchAllPodCast() async {
    response = BaseResponse.loading("Loading");
    await Repository().fetchPodCast().then((res) {
      if (res.items != null && res.items!.isNotEmpty) {
        response = BaseResponse.success(res);
      } else {
        response = BaseResponse.error('Something went wrong!');
      }
    }).catchError((error, st) {
      log('error; $error\nst:$st');
      response = BaseResponse.error(error.toString());
    });
    return response;
  }
}

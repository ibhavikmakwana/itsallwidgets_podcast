import 'dart:async';

import 'package:itsallwidgets_podcast/data/podcast_provider.dart';
import 'package:itsallwidgets_podcast/data/rss_response.dart';

class Repository {
  final podCastProvider = PCProvider();

  Future<RssResponse> fetchPodCast() => podCastProvider.fetchPodCast();
}

import 'package:itsallwidgets_podcast/data/repository.dart';
import 'package:itsallwidgets_podcast/data/rss_response.dart';
import 'package:rxdart/rxdart.dart';

final bloc = PodCastBloc();

class PodCastBloc {
  final _repository = Repository();
  final _podCastFetcher = PublishSubject<RssResponse>();

  Observable<RssResponse> get allPodCast => _podCastFetcher.stream;

  fetchAllPodCast() async {
    RssResponse response = await _repository.fetchPodCast();
    _podCastFetcher.sink.add(response);
  }

  dispose() {
    _podCastFetcher.close();
  }
}

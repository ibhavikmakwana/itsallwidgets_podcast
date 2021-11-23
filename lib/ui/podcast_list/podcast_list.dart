import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:itsallwidgets_podcast/ads/ad_helper.dart';
import 'package:itsallwidgets_podcast/data/rss_response.dart';
import 'package:itsallwidgets_podcast/network/base_response.dart';
import 'package:itsallwidgets_podcast/ui/custom/author_span_widget.dart';
import 'package:itsallwidgets_podcast/ui/custom/title_widget.dart';
import 'package:itsallwidgets_podcast/ui/detail/detail.dart';
import 'package:itsallwidgets_podcast/ui/detail/detail_store.dart';
import 'package:provider/provider.dart';

import 'list_item_view.dart';
import 'list_store.dart';

class PodCastList extends StatefulWidget {
  @override
  State<PodCastList> createState() => _PodCastListState();
}

class _PodCastListState extends State<PodCastList> {
  late final ListStore store;
  static final _kAdIndex = 10;
  late BannerAd _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _initGoogleMobileAds();
    store = ListStore();
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          log('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    _ad.load();
  }

  Future<InitializationStatus> _initGoogleMobileAds() =>
      MobileAds.instance.initialize();

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Observer(
          builder: (context) {
            switch (store.response!.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TitleWidget(title: store.response?.data?.title),
                            Container(
                              color: Colors.blue,
                              height: 3,
                              width: 50,
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                            ),
                            AuthorSpanWidget(
                              authorText: store.response?.data?.author?.name,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 8),
                              child: Text(
                                store.response?.data?.description ?? '',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final RssResponse feed = store.response!.data!;
                                final Item item =
                                    store.response!.data!.items![index]!;
                                return ListItemView(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) => Provider(
                                          create: (_) => DetailStore(),
                                          child: PodCastDetail(item, feed),
                                        ),
                                      ),
                                    );
                                  },
                                  item: item,
                                  feed: store.response!.data,
                                );
                              },
                              itemCount:
                                  store.response?.data?.items?.length ?? 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isAdLoaded)
                      Container(
                        child: AdWidget(ad: _ad),
                        width: _ad.size.width.toDouble(),
                        height: 72.0,
                        alignment: Alignment.center,
                      )
                  ],
                );
              case Status.ERROR:
                return Center(child: Text('${store.response!.message}'));
              default:
                return Center(child: Text('${store.response!.message}'));
            }
          },
        ),
      ),
    );
  }
}

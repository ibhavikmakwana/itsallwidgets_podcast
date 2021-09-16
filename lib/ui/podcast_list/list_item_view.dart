import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itsallwidgets_podcast/data/rss_response.dart';

import 'package:itsallwidgets_podcast/ui/detail/detail.dart';
import 'package:itsallwidgets_podcast/ui/detail/detail_store.dart';
import 'package:provider/provider.dart';

class ListItemView extends StatelessWidget {
  final Items item;
  final Feed feed;

  const ListItemView({Key key, this.item, this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => Provider(
              create: (_) => DetailStore(),
              // dispose: (_, DetailStore store) => store.dispose(),
              child: PodCastDetail(item, feed),
            ),
          ),
        );
      },
      contentPadding:
          const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      title: Text(item.title),
      leading: Hero(
        tag: item.title,
        child: FadeInImage(
          placeholder: AssetImage('assets/app_icon.png'),
          image: NetworkImage(feed.image),
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

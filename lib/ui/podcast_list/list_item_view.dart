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
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => Provider(
                builder: (_) => DetailStore(),
                dispose: (_, DetailStore store) => store.dispose(),
                child: PodCastDetail(item, feed),
              ),
            ),
          );
        },
        contentPadding: EdgeInsets.all(8),
        trailing: Icon(Icons.navigate_next),
        title: Text(item.title),
        leading: ClipOval(
          child: Hero(
            tag: item.title,
            child: Image.network(
              item.thumbnail,
              fit: BoxFit.cover,
              height: 48,
              width: 48,
            ),
          ),
        ),
      ),
    );
  }
}

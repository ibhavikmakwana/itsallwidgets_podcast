import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsallwidgets_podcast/data/rss_response.dart';

class ListItemView extends StatelessWidget {
  final Item? item;
  final RssResponse? feed;
  final GestureTapCallback? onTap;

  const ListItemView({Key? key, this.item, this.feed, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding:
          const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      title: Text(item!.title!),
      leading: Hero(
        tag: item!.title!,
        child: FadeInImage(
          placeholder: AssetImage('assets/app_icon.png'),
          image: NetworkImage('https://itsallwidgets.com/images/podcast.jpg'),
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

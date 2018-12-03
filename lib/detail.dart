import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsallwidgets_podcast/rss_response.dart';

class PodCastDetail extends StatelessWidget {
  final Items item;
  final Feed feed;

  PodCastDetail(this.item, this.feed);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: item.title,
                    child: Image.network(feed.image),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  item.title,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              buildBlueDivider(),
              buildAudioView(),
            ],
          ),
        ),
      ),
    );
  }

  buildBlueDivider() {
    return Container(
      color: Colors.blue,
      height: 3,
      width: 50,
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    );
  }

  buildAudioView() {
    return Container(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(), color: Colors.black12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

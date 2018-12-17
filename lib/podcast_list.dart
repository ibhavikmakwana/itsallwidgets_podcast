import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsallwidgets_podcast/bloc/podcast_bloc.dart';
import 'package:itsallwidgets_podcast/data/rss_response.dart';
import 'package:itsallwidgets_podcast/detail.dart';
import 'package:url_launcher/url_launcher.dart';

class PodCastList extends StatelessWidget {
//  final recognizer = TapGestureRecognizer()
//    ..onTap = () {
//      _launchURL();
//    };

  _launchURL() async {
    const url = 'https://twitter.com/hillelcoren';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllPodCast();
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: bloc.allPodCast,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildTitleWidget(snapshot),
                    buildBlueDivider(),
                    textAuthorSpan(snapshot.data.feed.author),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                      child: Text(
                        snapshot.data.feed.description,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildListViewItem(snapshot, index, context);
                      },
                      itemCount: snapshot.data.items.length,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  buildListViewItem(
      AsyncSnapshot<RssResponse> snapshot, int index, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) =>
                  PodCastDetail(snapshot.data.items[index], snapshot.data.feed),
            ),
          );
        },
        contentPadding: EdgeInsets.all(8),
        trailing: Icon(Icons.navigate_next),
        title: Text(snapshot.data.items[index].title),
        leading: ClipOval(
          child: Hero(
            tag: snapshot.data.items[index].title,
            child: Image.network(
              snapshot.data.feed.image,
              fit: BoxFit.cover,
              height: 48,
              width: 48,
            ),
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

  Padding buildTitleWidget(AsyncSnapshot<RssResponse> snapshot) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      child: Text(
        snapshot.data.feed.title,
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      ),
    );
  }

  textAuthorSpan(String author) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Hosted by ',
              style: TextStyle(
                color: Colors.blue.shade500,
              ),
            ),
            TextSpan(
              text: author,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}

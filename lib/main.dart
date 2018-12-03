import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itsallwidgets_podcast/detail.dart';
import 'package:itsallwidgets_podcast/rss_response.dart';
import 'package:xml2json/xml2json.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Xml2Json myTransformer = Xml2Json();
  Future<RssResponse> rssResponse;

  @override
  void initState() {
    super.initState();
    rssResponse = fetchPodCast();
  }

  final recognizer = TapGestureRecognizer()
    ..onTap = () {
      print("You have tapped Hillel");
    };

  Future<RssResponse> fetchPodCast() async {
    final response = await http.get(
        'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fitsallwidgets.com%2Fpodcast%2Ffeed');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return RssResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load podcast');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<RssResponse>(
          future: rssResponse,
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
                        return buildListViewItem(snapshot, index);
                      },
                      itemCount: snapshot.data.items.length,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  buildListViewItem(AsyncSnapshot<RssResponse> snapshot, int index) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => PodCastDetail(snapshot.data.items[index],snapshot.data.feed)));
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
              recognizer: recognizer,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsallwidgets_podcast/podcast_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'It\'s all widgets podcast',
      home: PodCastList(),
    );
  }
}
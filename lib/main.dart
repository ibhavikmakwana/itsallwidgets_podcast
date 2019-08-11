import 'package:flutter/material.dart';
import 'package:itsallwidgets_podcast/values/strings.dart';
import 'package:itsallwidgets_podcast/ui/podcast_list/podcast_list.dart';
import 'package:provider/provider.dart';

import 'ui/podcast_list/list_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'MajorMonoDisplay',
      ),
      home: Provider(
        builder: ((_) => ListStore()),
        dispose: (_, ListStore store) => store.dispose(),
        child: PodCastList(),
      ),
    );
  }
}

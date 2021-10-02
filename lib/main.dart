import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itsallwidgets_podcast/ui/podcast_list/podcast_list.dart';
import 'package:itsallwidgets_podcast/values/strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: PodCastList(),
    );
  }
}

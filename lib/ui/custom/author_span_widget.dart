import 'package:flutter/material.dart';

class AuthorSpanWidget extends StatelessWidget {
  final String? authorText;

  const AuthorSpanWidget({Key? key, required this.authorText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: "MajorMonoDisplay",
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Hosted by ',
              style: TextStyle(
                color: Colors.blue.shade500,
                fontFamily: "MajorMonoDisplay",
              ),
            ),
            TextSpan(
              text: authorText,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.blue.shade900,
                fontFamily: "MajorMonoDisplay",
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

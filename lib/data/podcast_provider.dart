import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:itsallwidgets_podcast/data/rss_response.dart';

class PCProvider {
  Future<RssResponse> fetchPodCast() async {
    final response = await http.get(
      Uri.parse(
        'https://feed2json.org/convert?url=https%3A%2F%2Fitsallwidgets.com%2Fpodcast%2Ffeed',
      ),
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return RssResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load podcast');
    }
  }
}

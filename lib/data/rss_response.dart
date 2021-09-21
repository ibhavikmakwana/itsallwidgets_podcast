// To parse this JSON data, do
//
//     final rssResponse = rssResponseFromJson(jsonString);

import 'dart:convert';

RssResponse rssResponseFromJson(String str) =>
    RssResponse.fromJson(json.decode(str));

String rssResponseToJson(RssResponse data) => json.encode(data.toJson());

class RssResponse {
  RssResponse({
    this.version,
    this.title,
    this.homePageUrl,
    this.description,
    this.author,
    this.items,
  });

  String? version;
  String? title;
  String? homePageUrl;
  String? description;
  Author? author;
  List<Item?>? items;

  factory RssResponse.fromJson(Map<String, dynamic> json) => RssResponse(
        version: json["version"],
        title: json["title"],
        homePageUrl: json["home_page_url"],
        description: json["description"],
        author: json["author"] != null ? Author.fromJson(json["author"]) : null,
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "title": title,
        "home_page_url": homePageUrl,
        "description": description,
        "author": author?.toJson() ?? '',
        "items": items != null
            ? List<dynamic>.from(items!.map((x) => x!.toJson()))
            : [],
      };
}

class Author {
  Author({
    this.name,
  });

  String? name;

  factory Author.fromJson(Map<String, dynamic> json) =>
      Author(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}

class Item {
  Item({
    this.guid,
    this.url,
    this.title,
    this.contentHtml,
    this.summary,
    this.datePublished,
    this.author,
  });

  String? guid;
  String? url;
  String? title;
  String? contentHtml;
  String? summary;
  DateTime? datePublished;
  Author? author;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        guid: json["guid"],
        url: json["url"],
        title: json["title"],
        contentHtml: json["content_html"],
        summary: json["summary"],
        datePublished: DateTime.parse(json["date_published"]),
        author: Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "guid": guid,
        "url": url,
        "title": title,
        "content_html": contentHtml,
        "summary": summary,
        "date_published": datePublished?.toIso8601String(),
        "author": author?.toJson(),
      };
}

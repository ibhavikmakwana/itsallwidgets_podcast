class RssResponse {
  String status;
  String message;
  Feed feed;
  List<Items> items;

  RssResponse({this.status, this.feed, this.items});

  RssResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    feed = json['feed'] != null ? new Feed.fromJson(json['feed']) : null;
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.feed != null) {
      data['feed'] = this.feed.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feed {
  String url;
  String title;
  String link;
  String author;
  String description;
  String image;

  Feed(
      {this.url,
        this.title,
        this.link,
        this.author,
        this.description,
        this.image});

  Feed.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
    link = json['link'];
    author = json['author'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['title'] = this.title;
    data['link'] = this.link;
    data['author'] = this.author;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}

class Items {
  String title;
  String pubDate;
  String link;
  String guid;
  String author;
  String thumbnail;
  String description;
  String content;
  Enclosure enclosure;

  Items(
      {this.title,
        this.pubDate,
        this.link,
        this.guid,
        this.author,
        this.thumbnail,
        this.description,
        this.content,
        this.enclosure,});

  Items.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    pubDate = json['pubDate'];
    link = json['link'];
    guid = json['guid'];
    author = json['author'];
    thumbnail = json['thumbnail'];
    description = json['description'];
    content = json['content'];
    enclosure = json['enclosure'] != null
        ? new Enclosure.fromJson(json['enclosure'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['pubDate'] = this.pubDate;
    data['link'] = this.link;
    data['guid'] = this.guid;
    data['author'] = this.author;
    data['thumbnail'] = this.thumbnail;
    data['description'] = this.description;
    data['content'] = this.content;
    if (this.enclosure != null) {
      data['enclosure'] = this.enclosure.toJson();
    }
    return data;
  }
}

class Enclosure {
  String link;
  String type;
  int duration;
  Rating rating;

  Enclosure({this.link, this.type, this.duration, this.rating});

  Enclosure.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    type = json['type'];
    duration = json['duration'];
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['type'] = this.type;
    data['duration'] = this.duration;
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    return data;
  }
}

class Rating {
  String scheme;
  String value;

  Rating({this.scheme, this.value});

  Rating.fromJson(Map<String, dynamic> json) {
    scheme = json['scheme'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheme'] = this.scheme;
    data['value'] = this.value;
    return data;
  }
}
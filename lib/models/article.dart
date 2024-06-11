// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

import 'package:training/models/social_media.dart';

List<Article> articleFromJson(String str) => List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));
String articleToJson(List<Article> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Article {
  int id;
  String tajuk;
  DateTime tarikhPublish;
  String penulis;
  String kategori;
  String content;
  String about;
  String? thumbnail;
  List<SocialMedia> socialMedia;

  Article({
    required this.id,
    required this.tajuk,
    required this.tarikhPublish,
    required this.penulis,
    required this.kategori,
    required this.content,
    required this.about,
    this.thumbnail,
    required this.socialMedia,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    tajuk: json["tajuk"],
    tarikhPublish: DateTime.parse(json["tarikh_publish"]),
    penulis: json["penulis"],
    kategori: json["kategori"],
    content: json["content"],
    about: json["about"],
    thumbnail: json["thumbnail"],
    socialMedia: json["social_media"] == null ? [] : List<SocialMedia>.from(json["social_media"].map((x) => SocialMedia.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tajuk": tajuk,
    "tarikh_publish": "${tarikhPublish.year.toString().padLeft(4, '0')}-${tarikhPublish.month.toString().padLeft(2, '0')}-${tarikhPublish.day.toString().padLeft(2, '0')}",
    "penulis": penulis,
    "kategori": kategori,
    "content": content,
    "about": about,
    "thumbnail": thumbnail,
    "social_media": List<dynamic>.from(socialMedia.map((x) => x.toJson())),
  };
}

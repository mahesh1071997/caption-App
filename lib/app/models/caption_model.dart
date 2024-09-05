// To parse this JSON data, do
//
//     final caption = captionFromJson(jsonString);

import 'dart:convert';

Caption captionFromJson(String str) => Caption.fromJson(json.decode(str));

String captionToJson(Caption data) => json.encode(data.toJson());

class Caption {
  final String? title;
  final List<String>? hashtags;
  final String? caption;

  Caption({
    this.title,
    this.hashtags,
    this.caption,
  });

  Caption copyWith({String? title, List<String>? tags, String? caption,}) =>
      Caption(title: title ?? this.title, hashtags: tags ?? this.hashtags, caption: caption ?? this.caption,);

  factory Caption.fromJson(Map<String, dynamic> json) => Caption(
    title: json["title"],
    hashtags: json["hashtags"] == null ? [] : List<String>.from(json["hashtags"]!.map((x) => x)),
    caption: json["caption"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "hashtags": hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
    "caption": caption,
  };
}

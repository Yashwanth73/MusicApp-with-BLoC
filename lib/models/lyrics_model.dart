// To parse this JSON data, do
//
//     final trackLyrics = trackLyricsFromJson(jsonString);

import 'dart:convert';

TrackLyrics trackLyricsFromJson(String str) =>
    TrackLyrics.fromJson(json.decode(str));

String trackLyricsToJson(TrackLyrics data) => json.encode(data.toJson());

class TrackLyrics {
  TrackLyrics({
    required this.message,
  });

  Message message;

  factory TrackLyrics.fromJson(Map<String, dynamic> json) => TrackLyrics(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.header,
    required this.body,
  });

  Header header;
  Body body;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        header: Header.fromJson(json["header"]),
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "body": body.toJson(),
      };
}

class Body {
  Body({
    required this.lyrics,
  });

  Lyrics lyrics;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        lyrics: Lyrics.fromJson(json["lyrics"]),
      );

  Map<String, dynamic> toJson() => {
        "lyrics": lyrics.toJson(),
      };
}

class Lyrics {
  Lyrics({
    required this.lyricsBody,
  });

  String lyricsBody;

  factory Lyrics.fromJson(Map<String, dynamic> json) => Lyrics(
        lyricsBody: json["lyrics_body"],
      );

  Map<String, dynamic> toJson() => {
        "lyrics_body": lyricsBody,
      };
}

class Header {
  Header({
    required this.statusCode,
    required this.executeTime,
  });

  int statusCode;
  double executeTime;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        statusCode: json["status_code"],
        executeTime: json["execute_time"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "execute_time": executeTime,
      };
}

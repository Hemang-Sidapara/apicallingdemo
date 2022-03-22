// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory User.fromJson(Map<String, dynamic> json) => User(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  Result({
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  String title;
  String overview;
  String posterPath;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    title: json["title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
  );

  Map<String, dynamic> toJson() => {
    "original_title": title,
    "overview": overview,
    "poster_path": posterPath,
  };
}

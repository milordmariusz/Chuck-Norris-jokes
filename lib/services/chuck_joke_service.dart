import 'dart:convert';

import 'package:http/http.dart';

ChuckJoke chuckJokeFromJson(String str) => ChuckJoke.fromJson(json.decode(str));

String chuckJokeToJson(ChuckJoke data) => json.encode(data.toJson());

class ChuckJoke {
  ChuckJoke({
    required this.type,
    required this.value,
  });

  String type;
  Value value;

  factory ChuckJoke.fromJson(Map<String, dynamic> json) => ChuckJoke(
    type: json["type"],
    value: Value.fromJson(json["value"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value.toJson(),
  };
}

class Value {
  Value({
    required this.id,
    required this.joke,
    required this.categories,
  });

  int id;
  String joke;
  List<dynamic> categories;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"],
    joke: json["joke"],
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "joke": joke,
    "categories": List<dynamic>.from(categories.map((x) => x)),
  };
}

class ChuckJokeService{
  Future<ChuckJoke> getChuckJoke() async {
    final response = await get(Uri.parse('http://api.icndb.com/jokes/random'));
    final chuckJoke = chuckJokeFromJson(response.body);
    return chuckJoke;
  }
}
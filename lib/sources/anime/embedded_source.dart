import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unyo/sources/sources.dart';
import 'package:unyo/util/utils.dart';

class EmbeddedSource implements AnimeSource {
  const EmbeddedSource({required this.source, required this.name});

  final String source;
  final String name;
  final String embeddedServerEndPoint = "https://kevin-is-awesome.mooo.com/api";

  @override
  Future<StreamData> getAnimeStreamAndCaptions(
      String id, int episode, BuildContext context) async {
    var urlStream = Uri.parse("$embeddedServerEndPoint/unyo/streamAndCaptions");
    Map<String, dynamic> requestBody = {
      "source": source,
      "id": id,
      "episode": episode
    };
    var response = await http.post(urlStream,
        body: json.encode(requestBody),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode != 200) {
      return StreamData.empy();
    }
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> streams = jsonResponse["streams"];
    List<dynamic> qualities = jsonResponse["qualities"];
    List<dynamic> captionsResponse = jsonResponse["captions"];
    captionsResponse.removeWhere((element) => element == "");
    List<List<CaptionData>>? captions = captionsResponse.isNotEmpty
        ? captionsResponse
            .map((e) => (e as String)
                .split("@")
                .map((e) =>
                    CaptionData(file: e.split(";")[0], lang: e.split(";")[1]))
                .toList())
            .toList()
        : null;
    List<dynamic> tracksResponse = jsonResponse["subtracks"];
    tracksResponse.removeWhere((element) => element == "");
    List<List<TrackData>>? tracks = tracksResponse.isNotEmpty
        ? tracksResponse
            .map((e) => (e as String)
                .split("@")
                .map((e) =>
                    TrackData(file: e.split(";")[0], lang: e.split(";")[1]))
                .toList())
            .toList()
        : null;

    List<dynamic>? headersKeys = jsonResponse["headersKeys"] != "null"
        ? jsonResponse["headersKeys"]
        : null;
    List<dynamic>? headersValues = jsonResponse["headersNames"] != "null"
        ? jsonResponse["headersNames"]
        : null;
    //Not sure about the inner strings conversion, might need to manually cast
    List<List<String>> headersKeysProcessed = [];
    List<List<String>> headersValuesProcessed = [];
    if (headersKeys != null) {
      for (var headersKey in headersKeys) {
        headersKeysProcessed.add(
            (headersKey as List<dynamic>).map((e) => e as String).toList());
      }
      for (var headersValue in headersValues!) {
        headersValuesProcessed.add(
            (headersValue as List<dynamic>).map((e) => e as String).toList());
      }
    }
// return [
//       streams.map((e) => e as String).toList(),
//       captions?.map((e) => e as String).toList(),
//       headersKeysProcessed,
//       headersValuesProcessed,
//       qualities.map((e) => e as String).toList(),
//       subtracks?.map((e) => e as String).toList(),
//     ];
    return StreamData(
      streams: streams.map((e) => e as String).toList(),
      qualities: qualities.map((e) => e as String).toList(),
      captions: captions,
      tracks: tracks,
      headersKeys: headersKeysProcessed,
      headersValues: headersValuesProcessed,
    );
  }

  @override
  Future<List<List<String>>> getAnimeTitlesAndIds(String query) async {
    var urlStream = Uri.parse(
        "$embeddedServerEndPoint/unyo/titleAndIds?source=$source&query=$query");
    var response = await http.get(urlStream);

    if (response.statusCode != 200) {
      print(response.body);
      return [[], []];
    }

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    List<dynamic> titles = jsonResponse["titles"] ?? [];
    List<dynamic> ids = jsonResponse["ids"] ?? [];
    return [
      titles.map((e) => e as String).toList(),
      ids.map((e) => e as String).toList()
    ];
  }

  @override
  String getSourceName() {
    return name;
  }
}

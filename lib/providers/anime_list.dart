import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AnimeList with ChangeNotifier {
  List<dynamic>? _animeList = [];
  List<dynamic>? _libraryList = [];

  List<dynamic> get animeList {
    return [..._animeList!];
  }

  List<dynamic> get libraryList {
    return [..._libraryList!];
  }

  Future<void> fetchAndSetData(String term) async {
    final url = Uri.parse('https://kitsu.io/api/edge/anime?filter[text]=$term');
    final res = await http.get(
      url,
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-type': 'application/vnd.api+json',
      },
    );
    _animeList = json.decode(res.body)['data'];
    notifyListeners();
    return;
  }

  Future<List<dynamic>?> getAnimeById(String id) async {
    final url = Uri.parse('https://kitsu.io/api/edge/anime?filter[id]=$id');
    final res = await http.get(
      url,
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-type': 'application/vnd.api+json',
      },
    );
    return json.decode(res.body)['data'];
  }

  bool inLibrary(String id) {
    final index = _libraryList!.indexWhere((element) => element[0]['id'] == id);
    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }

  void addToLibrary(String id) {
    final index = _libraryList!.indexWhere((element) => element[0]['id'] == id);
    if (index == -1) {
      _libraryList!
          .add(animeList.where((element) => element['id'] == id).toList());
    } else {
      _libraryList!.removeAt(index);
    }
    notifyListeners();
  }
}

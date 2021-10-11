import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AnimeList with ChangeNotifier {
  List<dynamic>? _animeList = [];
  List<dynamic>? _libraryList = [];
  bool isInit = false;

  List<dynamic> get animeList {
    return [..._animeList!];
  }

  List<dynamic> get libraryList {
    // If this is the first time loading the
    // app, check the storage for favs
    if (!isInit) {
      fetchLibraryPrefs();
      isInit = true;
    }
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

  Future<void> addToLibrary(String id) async {
    // Is it in the library already?
    final index = _libraryList!.indexWhere((element) => element[0]['id'] == id);
    final prefs = await SharedPreferences.getInstance();
    if (index == -1) {
      // add to the library and store on the device
      _libraryList!
          .add(animeList.where((element) => element['id'] == id).toList());
      await prefs.setString(
          "$id",
          json.encode(
              animeList.where((element) => element['id'] == id).toList()));
    } else {
      // remove it from both the library and the storage
      _libraryList!.removeAt(index);
      await prefs.remove("$id");
    }
    notifyListeners();
    return;
  }

  Future<void> fetchLibraryPrefs() async {
    // open the storage and get the keys
    final prefs = await SharedPreferences.getInstance();
    final values = prefs.getKeys();
    if (values.isEmpty) {
      return;
    }
    // Add the items in storage to the library
    values.forEach((key) {
      _libraryList!.add(json.decode(prefs.get(key).toString()));
    });
    notifyListeners();
    return;
  }

  void setRating(String id, int rating) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> oldValues = prefs.get('ratings') == null
        ? []
        : new List<Map<String, dynamic>>.from(
            json.decode(prefs.get('ratings') as String),
          );
    int index = oldValues.indexWhere((element) {
      return element.containsKey(id);
    });
    index == -1
        ? oldValues.add({'$id': rating})
        : oldValues[index] = {'$id': rating};
    prefs.setString('ratings', json.encode(oldValues));
  }

  Future<int> getRating(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> oldValues = prefs.get('ratings') == null
        ? []
        : new List<Map<String, dynamic>>.from(
            json.decode(prefs.get('ratings') as String),
          );
    if (oldValues.isEmpty) {
      return 0;
    }
    int index = oldValues.indexWhere((element) {
      return element.containsKey(id);
    });
    if (index == -1) {
      return 0;
    } else {
      return oldValues[index].values.first;
    }
  }
}

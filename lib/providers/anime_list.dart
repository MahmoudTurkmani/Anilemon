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
    final List<Map<String, dynamic>> values = prefs.get('library') == null
        ? []
        : new List<Map<String, dynamic>>.from(
            json.decode(prefs.get('library') as String),
          );
    int prefsIndex = values.indexWhere((element) {
      return element.containsKey(id);
    });
    if (index == -1) {
      // add to the library and store on the device
      _libraryList!
          .add(animeList.where((element) => element['id'] == id).toList());
      values.add(
          {"$id": animeList.where((element) => element['id'] == id).toList()});
      await prefs.setString('library', json.encode(values));
    } else {
      // remove it from both the library and the storage
      _libraryList!.removeAt(index);
      values.removeAt(prefsIndex);
      await prefs.setString('library', json.encode(values));
    }
    notifyListeners();
    return;
  }

  Future<void> fetchLibraryPrefs() async {
    // open the storage and get the keys
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> values = prefs.get('library') == null
        ? []
        : new List<Map<String, dynamic>>.from(
            json.decode(prefs.get('library') as String),
          );
    if (values.isEmpty) {
      _libraryList = [];
      notifyListeners();
      return;
    }
    // Add the items in storage to the library
    values.forEach((element) {
      _libraryList!.add(element.values.first);
    });
    notifyListeners();
    return;
  }

  void setProperty(String property, String id, int value) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> oldValues = prefs.get('$property') == null
        ? []
        : new List<Map<String, dynamic>>.from(
            json.decode(prefs.get('$property') as String),
          );
    int index = oldValues.indexWhere((element) {
      return element.containsKey(id);
    });
    index == -1
        ? oldValues.add({'$id': value})
        : oldValues[index] = {'$id': value};
    prefs.setString('$property', json.encode(oldValues));
    notifyListeners();
  }

  Future<int> getProperty(String property, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> oldValues = prefs.get('property') == null
        ? []
        : new List<Map<String, dynamic>>.from(
            json.decode(prefs.get('property') as String),
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

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    fetchLibraryPrefs();
    notifyListeners();
    return;
  }
}

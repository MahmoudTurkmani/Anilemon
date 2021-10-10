import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/anime_list.dart';
import '../screens/search_results_screen.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  SearchScreen({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'What do you wanna search for?',
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (searchController.text.isEmpty) {
                  return;
                } else {
                  await Provider.of<AnimeList>(context, listen: false)
                      .fetchAndSetData(searchController.text);
                  Navigator.of(context).pushNamed(SearchResultScreen.routeName);
                }
              },
              icon: Icon(Icons.search),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

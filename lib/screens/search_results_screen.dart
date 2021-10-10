import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/anime_list.dart';
import '../widgets/list_item.dart';

class SearchResultScreen extends StatelessWidget {
  static const String routeName = '/search-results';
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Consumer<AnimeList>(
        builder: (ctx, animeConsumer, ch) {
          return ListView.builder(
            itemCount: animeConsumer.animeList.length,
            itemBuilder: (c, index) {
              return ListItem(
                id: animeConsumer.animeList[index]['id'],
                type: animeConsumer.animeList[index]['type'],
                imageUrl: animeConsumer.animeList[index]['attributes']
                    ['posterImage']['medium'],
                title: animeConsumer.animeList[index]['attributes']['slug'],
              );
            },
          );
        },
      ),
    );
  }
}

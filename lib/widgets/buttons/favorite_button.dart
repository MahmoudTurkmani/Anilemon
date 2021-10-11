import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/anime_list.dart';

class FavoriteButton extends StatelessWidget {
  final String id;
  const FavoriteButton(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimeList>(
      builder: (_, animeList, ch) {
        return Column(
          children: [
            Text('Add to favs'),
            IconButton(
              onPressed: () => animeList.addToLibrary(
                id,
              ),
              icon: Icon(
                  animeList.inLibrary(id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red),
            ),
          ],
        );
      },
    );
  }
}

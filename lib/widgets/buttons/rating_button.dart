import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/anime_list.dart';

class RatingButton extends StatelessWidget {
  final String id;
  const RatingButton(this.id);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Rating'),
        IconButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (ctx) => SimpleDialog(
                children: [
                  Center(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 3,
                      children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map(
                            (element) => ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(element);
                              },
                              child: Text('$element'),
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              ),
            ).then(
              (value) {
                if (value == null) {
                  return;
                }
                Provider.of<AnimeList>(context, listen: false)
                    .setProperty('ratings', id, value);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Show rating successfully added'),
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.thumb_up, color: Colors.blue),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/anime_list.dart';

class EpsWatchedButton extends StatelessWidget {
  final String id;
  final int totalEps;
  const EpsWatchedButton(
    this.id,
    this.totalEps, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Eps watched'),
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
                      children: new List<int>.generate(totalEps, (i) => ++i)
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
                    .setProperty('eps', id, value);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Progress saved'),
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.remove_red_eye, color: Colors.brown),
        ),
      ],
    );
  }
}

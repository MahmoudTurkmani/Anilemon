import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/anime_list.dart';

class StatusButton extends StatelessWidget {
  final String id;
  const StatusButton(
    this.id, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Status'),
        IconButton(
          onPressed: () async {
            final values = ["plan to watch", "watching", "dropped", "on hold"];
            //  mapped as  [       0       ,     1     ,     2    ,     3    ]
            await showDialog(
              context: context,
              builder: (ctx) => SimpleDialog(
                children: [
                  Center(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 3,
                      children: values
                          .map(
                            (element) => ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(values
                                    .indexWhere((item) => item == element));
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
                    .setProperty('watchStatus', id, value);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Watch status successfully updated'),
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.movie, color: Colors.black),
        ),
      ],
    );
  }
}

import 'package:anilemon/providers/anime_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/anime_details_screen.dart';

class ListItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? type;
  final String? imageUrl;

  ListItem({
    @required this.id,
    @required this.type,
    @required this.imageUrl,
    @required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AnimeDetailsScreen(
            id: id,
            details: Provider.of<AnimeList>(context, listen: false)
                .animeList
                .where((element) => element['id'] == id)
                .toList(),
          ),
        ),
      ),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Container(
              height: 120,
              width: 80,
              constraints: BoxConstraints(maxWidth: 100),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(5),
                  bottomLeft: const Radius.circular(5),
                ),
                child: Hero(
                  tag: id!,
                  child: FadeInImage(
                    image: NetworkImage(imageUrl!),
                    placeholder: AssetImage("assets/images/placeholder.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${title![0].toUpperCase()}${title!.substring(1).replaceAll('-', ' ')}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    type!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}

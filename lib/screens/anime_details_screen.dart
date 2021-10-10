import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/anime_list.dart';
import '../widgets/watch_show_button.dart';

class AnimeDetailsScreen extends StatelessWidget {
  static const String routeName = '/anime-details';
  final String? id;
  final List<dynamic>? details;
  int count = 0;

  AnimeDetailsScreen({
    @required this.id,
    @required this.details,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                // To capitalize the first letter
                '${details![0]['attributes']['slug'][0].toString().toUpperCase()}${details![0]['attributes']['slug'].substring(1)}'
                    .replaceAll('-', " "),
                style: TextStyle(backgroundColor: Colors.black54),
              ),
              background: Hero(
                tag: id!,
                child: FadeInImage(
                  placeholder: AssetImage("assets/images/placeholder.png"),
                  image: NetworkImage(
                      details![0]['attributes']['posterImage']['medium']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          buildButton(Icons.movie, 'Status', () {}),
                          buildButton(
                              Icons.remove_red_eye, 'Eps watched', () {}),
                          buildButton(Icons.thumb_up, 'Rating', () {}),
                          Consumer<AnimeList>(
                            builder: (_, animeList, ch) {
                              return buildButton(
                                animeList.inLibrary(id!)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                'Add to favs',
                                () => animeList.addToLibrary(
                                  details![0]['id'],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      WatchShowButton(
                        title: details![0]['attributes']['slug'].toString(),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('+1'),
                      ),
                      // Outsource this too into another widget
                      Table(
                        border: TableBorder.all(
                          width: 0.2,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          buildRow(context, 'Average Rating',
                              '${details![0]['attributes']['averageRating']}/100',
                              isFirst: true),
                          buildRow(context, 'Release Date',
                              '${details![0]['attributes']['startDate']}'),
                          buildRow(context, 'Episode Count',
                              '${details![0]['attributes']['episodeCount']}'),
                          buildRow(context, 'Age Rating',
                              '${details![0]['attributes']['ageRating']}'),
                          buildRow(context, 'Type',
                              '${details![0]['attributes']['showType']}',
                              isLast: true),
                        ],
                      )
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(IconData icon, String label, VoidCallback func) {
    return Column(
      children: [
        Text('$label'),
        IconButton(
          onPressed: func,
          icon: Icon(icon, color: Colors.black),
        ),
      ],
    );
  }

  TableRow buildRow(BuildContext context, String label, String detail,
      {bool isFirst = false, bool isLast = false}) {
    count++;
    return TableRow(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? Radius.circular(5) : Radius.zero,
          topRight: isFirst ? Radius.circular(5) : Radius.zero,
          bottomLeft: isLast ? Radius.circular(5) : Radius.zero,
          bottomRight: isLast ? Radius.circular(5) : Radius.zero,
        ),
        color: count.isOdd
            ? Theme.of(context).colorScheme.primaryVariant
            : Theme.of(context).colorScheme.secondary,
      ),
      children: <Widget>[
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              '$label',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              '$detail',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }
}

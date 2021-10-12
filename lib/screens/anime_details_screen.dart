import 'package:flutter/material.dart';

import '../widgets/watch_show_button.dart';
import '../widgets/buttons/rating_button.dart';
import '../widgets/buttons/favorite_button.dart';
import '../widgets/buttons/eps_watched_button.dart';
import '../widgets/buttons/status_button.dart';
import '../widgets/info/details_table.dart';
import '../widgets/info/user_details_table.dart';
import '../widgets/info/synopsis.dart';

class AnimeDetailsScreen extends StatelessWidget {
  static const String routeName = '/anime-details';
  final String? id;
  final List<dynamic>? details;

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
                int epCount = (details![0]['attributes']['totalLength'] /
                        details![0]['attributes']['episodeLength'])
                    .round();
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          StatusButton(id!),
                          EpsWatchedButton(
                              id!,
                              details![0]['attributes']['episodeCount'] ??
                                  epCount),
                          RatingButton(id!),
                          FavoriteButton(id!),
                        ],
                      ),
                      WatchShowButton(
                        title: details![0]['attributes']['slug'].toString(),
                      ),
                      UserDetailsTable(id!),
                      SizedBox(
                        height: 8,
                      ),
                      DetailsTable(details!),
                      SizedBox(
                        height: 8,
                      ),
                      Synopsis(details![0]['attributes']['synopsis']),
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
}

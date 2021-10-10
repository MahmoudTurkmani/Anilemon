import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/anime_list.dart';
import '../screens/anime_details_screen.dart';

class LibraryGrid extends StatelessWidget {
  const LibraryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Consumer<AnimeList>(
        builder: (_, animeConsumer, ch) {
          return animeConsumer.libraryList.isEmpty
              ? Center(child: Image.asset('assets/images/not_found.png'))
              : GridView.builder(
                  itemCount: animeConsumer.libraryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => AnimeDetailsScreen(
                            id: animeConsumer.libraryList[index][0]['id'],
                            details: animeConsumer.libraryList[index],
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Card(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Hero(
                                  tag: animeConsumer.libraryList[index][0]
                                      ['id'],
                                  child: FadeInImage(
                                    width: double.infinity,
                                    placeholder: AssetImage(
                                        'assets/images/placeholder.png'),
                                    image: NetworkImage(
                                      animeConsumer.libraryList[index][0]
                                              ['attributes']['posterImage']
                                          ['small'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            // To make the first letter upercase
                            '${animeConsumer.libraryList[index][0]['attributes']['slug'].toString()[0].toUpperCase()}${animeConsumer.libraryList[index][0]['attributes']['slug'].toString().substring(1)}'
                                .replaceAll('-', ' '),
                            textAlign: TextAlign.start,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/anime_list.dart';

class UserDetailsTable extends StatefulWidget {
  final String id;
  const UserDetailsTable(
    this.id, {
    Key? key,
  }) : super(key: key);

  @override
  _UserDetailsTableState createState() => _UserDetailsTableState();
}

class _UserDetailsTableState extends State<UserDetailsTable> {
  int count = 0;
  int? rating, epsWatched;
  String? watchStatus;
  bool isInit = false;

  Future<void> initData() async {
    rating = await Provider.of<AnimeList>(context, listen: false)
        .getProperty('ratings', widget.id);
    epsWatched = await Provider.of<AnimeList>(context, listen: false)
        .getProperty('eps', widget.id);
    // Replace this with an enum later on (also the one in the status_button file)
    watchStatus = await Provider.of<AnimeList>(context, listen: false)
        .getProperty('watchStatus', widget.id)
        .then((value) {
      switch (value) {
        case 0:
          return "plan to watch";
        case 1:
          return "watching";
        case 2:
          return "completed";
        case 3:
          return "dropped";
        case 4:
          return "on hold";
        default:
      }
    });
    return;
  }

  @override
  void didChangeDependencies() {
    initData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    count = 0;
    return Consumer<AnimeList>(builder: (ctx, animeConsumer, ch) {
      return FutureBuilder(
          future: initData(),
          builder: (context, futureSnapshot) {
            return Table(
              border: TableBorder.all(
                width: 0.2,
                borderRadius: BorderRadius.circular(5),
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                buildRow(context, 'Watch Status', '$watchStatus',
                    isFirst: true),
                buildRow(context, 'Episodes Watched', '$epsWatched'),
                buildRow(context, 'Your rating', '$rating', isLast: true),
              ],
            );
          });
    });
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

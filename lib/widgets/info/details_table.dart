import 'package:flutter/material.dart';

class DetailsTable extends StatefulWidget {
  final List<dynamic> details;
  const DetailsTable(
    this.details, {
    Key? key,
  }) : super(key: key);

  @override
  _DetailsTableState createState() => _DetailsTableState();
}

class _DetailsTableState extends State<DetailsTable> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    count = 0;
    return Table(
      border: TableBorder.all(
        width: 0.2,
        borderRadius: BorderRadius.circular(5),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        buildRow(context, 'Average Rating',
            '${widget.details[0]['attributes']['averageRating']}/100',
            isFirst: true),
        buildRow(context, 'Release Date',
            '${widget.details[0]['attributes']['startDate']}'),
        buildRow(context, 'Episode Count',
            '${widget.details[0]['attributes']['episodeCount']}'),
        buildRow(context, 'Age Rating',
            '${widget.details[0]['attributes']['ageRating']}'),
        buildRow(
            context, 'Type', '${widget.details[0]['attributes']['showType']}',
            isLast: true),
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

import 'package:flutter/material.dart';

class Synopsis extends StatefulWidget {
  final String synopsis;
  const Synopsis(
    this.synopsis, {
    Key? key,
  }) : super(key: key);

  @override
  _SynopsisState createState() => _SynopsisState();
}

class _SynopsisState extends State<Synopsis> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Synopsis',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                isExpanded = !isExpanded;
              }),
              icon: Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              color: Colors.black,
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryVariant,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey,
              width: 0.4,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(isExpanded ? 5.0 : 0.0),
            child: isExpanded
                ? Text(
                    widget.synopsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

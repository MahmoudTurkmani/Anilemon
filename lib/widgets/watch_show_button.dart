import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WatchShowButton extends StatefulWidget {
  final String? title;

  WatchShowButton({
    @required this.title,
    Key? key,
  }) : super(key: key);

  @override
  _WatchShowButtonState createState() => _WatchShowButtonState();
}

class _WatchShowButtonState extends State<WatchShowButton> {
  String link = 'https://animekisa.tv/search?q=';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Website:'),
            // for some spacing
            SizedBox(
              width: 10,
            ),
            DropdownButton(
              value: link,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (value) {
                setState(() {
                  link = value.toString();
                });
              },
              items: [
                DropdownMenuItem(
                  child: Text('AnimeKisa'),
                  value: 'https://animekisa.tv/search?q=',
                ),
                DropdownMenuItem(
                  child: Text('9anime'),
                  value: 'https://9anime.gg/search/?keyword=',
                ),
                DropdownMenuItem(
                  child: Text('GOGO Anime'),
                  value: 'https://gogoanime2.org/search/',
                ),
              ],
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Hardcoding the value for now
            final url = '$link${widget.title!.replaceAll('-', ' ')}';
            launch(url);
          },
          label: Text('Start Watching'),
          icon: Icon(Icons.open_in_new),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/navigation/main_navbar.dart';
import '../providers/anime_list.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).errorColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  icon: Icon(Icons.delete),
                  label: Text('Clear all data'),
                  onPressed: () async {
                    await Provider.of<AnimeList>(context, listen: false)
                        .clearData()
                        .then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Data successfully cleared'),
                            ),
                          ),
                        );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavBar(),
    );
  }
}

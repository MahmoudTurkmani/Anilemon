import 'package:flutter/material.dart';

import '../../screens/settings_screen.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.secondary,
      shape: CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
              icon: Icon(
                Icons.home,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(SettingsScreen.routeName),
              icon: Icon(Icons.settings),
            )
          ],
        ),
      ),
    );
  }
}

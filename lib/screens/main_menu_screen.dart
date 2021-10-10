import 'package:flutter/material.dart';

import '../widgets/navigation/main_navbar.dart';
import '../widgets/library_grid.dart';
import './search_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Anilemon'),
      ),
      body: LibraryGrid(),
      bottomNavigationBar: MainNavBar(),
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(SearchScreen.routeName),
          child: Icon(Icons.search)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

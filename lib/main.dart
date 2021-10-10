import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/main_menu_screen.dart';
import './screens/search_screen.dart';
import './screens/search_results_screen.dart';
import './providers/anime_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AnimeList(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.light().copyWith(
            primary: Color.fromRGBO(61, 86, 178, 1),
            primaryVariant: Color.fromRGBO(92, 122, 234, 1),
            secondary: Color.fromRGBO(61, 86, 178, 1),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
            ),
          ),
          scaffoldBackgroundColor: Color.fromRGBO(254, 249, 239, 1),
          iconTheme: IconThemeData(color: Colors.white),
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(foregroundColor: Colors.white),
        ),
        routes: {
          // another one is the anime_details_screen (didn't add here cuz has args)
          '/': (ctx) => MainMenu(),
          SearchScreen.routeName: (ctx) => SearchScreen(),
          SearchResultScreen.routeName: (ctx) => SearchResultScreen(),
        },
      ),
    );
  }
}

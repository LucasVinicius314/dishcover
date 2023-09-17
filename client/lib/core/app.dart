import 'package:dishcover_client/screens/home_page.dart';
import 'package:dishcover_client/utils/constants.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        cardTheme: const CardTheme(margin: EdgeInsets.zero),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        HomePage.route: (context) => const HomePage(),
      },
    );
  }
}

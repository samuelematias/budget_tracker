import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../budget/pages/pages.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Device Orientation only Portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //Transparent statusBar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Tracker',
      home: const BudgetTrackerPage(),
      theme: ThemeData.dark(),
    );
  }
}

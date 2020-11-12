import 'package:flutter/material.dart';
import 'package:pomotroid/constants.dart';
import 'package:pomotroid/pages/homepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/modes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  MyApp(this.prefs);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (context) => !prefs.containsKey(ROUND_KEY)
            ? ModesProvider()
            : ModesProvider.fromSharedPrefs(
                prefs.getInt(ROUND_KEY),
                prefs.getInt(FOCUS_DURATION_KEY),
                prefs.getInt(SHORT_BREAK_DURATION_KEY),
                prefs.getInt(LONG_BREAK_DURATION_KEY)),
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Color(0xff2f384b),
          ),
          home: Home(),
        ));
  }
}

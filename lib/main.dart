import 'package:flutter/material.dart';
import 'package:pomotroid/pages/homepage.dart';
import 'package:provider/provider.dart';

import 'model/states.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ModesProvider(),
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Color(0xff2f384b),
          ),
          home: Home(),
        ));
  }
}

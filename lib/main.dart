import 'package:adventure_time_quote_generator/features/quote_generator/presentation/pages/bmo_page.dart';
import 'package:flutter/material.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BmoPage(),
      theme: ThemeData(
        fontFamily: 'NESCyrillic',
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 30.0),
          body2: TextStyle(fontSize: 16.0, fontFamily: 'Wizard'),
        ),
      ),
    );
  }
}

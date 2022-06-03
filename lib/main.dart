import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_resep/models/firstpage.dart';
import 'package:project_resep/login_page.dart';

import 'package:project_resep/models/fav.dart';
import 'package:project_resep/register_page.dart';

Future main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavAdapter());
  await Hive.openBox<Fav>('fav');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Firstpage(),
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/HomePage': (BuildContext context) => new Firstpage(),
        '/LoginPage': (BuildContext context) => new LoginPage(),
        '/Register': (BuildContext context) => new RegisterPage(),
      },
    );
  }
}

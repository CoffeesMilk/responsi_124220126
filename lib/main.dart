import 'package:flutter/material.dart';
import 'package:responsi_124220126/pages/homepage.dart';
import 'package:responsi_124220126/pages/registerpage.dart';
import 'package:responsi_124220126/pages/loginpage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/user.dart';
import 'models/boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(userAdapter());
  await Hive.openBox(HiveBoxex.user);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: loginpage(),
    );
  }
}

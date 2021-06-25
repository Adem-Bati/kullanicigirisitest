import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/opening.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } on Exception catch (e) {
    print(e);
    // TODO
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterFire Provider Template',
      home: OpeningView(),
    );
  }
}

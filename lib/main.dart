import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'photo_list_screen.dart';

void main() async{
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mars Photos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoListPage(),
    );
  }
}


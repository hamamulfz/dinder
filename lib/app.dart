
import 'package:flutter/material.dart';

import 'breed_list/view/breed_list_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dating App for Dogs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BreedListScreen(),
    );
  }
}

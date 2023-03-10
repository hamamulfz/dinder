
import 'package:flutter/material.dart';

import 'pages/breed_list/view/breed_list_screen.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dinder',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const BreedListScreen(),
    );
  }
}

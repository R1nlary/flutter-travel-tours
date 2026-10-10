import 'package:flutter/material.dart';

import 'screens/registration_screen.dart';

void main() {
  runApp(const TravelToursApp());
}

class TravelToursApp extends StatelessWidget {
  const TravelToursApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Tours',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const RegistrationScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:money_manage/screens/home_screen.dart';
import 'package:money_manage/screens/onboarding_screen.dart';
import 'package:money_manage/widget/report_widget.dart';

import 'home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}



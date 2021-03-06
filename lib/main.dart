import 'package:flutter/material.dart';

import 'screen/training_plan_list_page.dart';
import 'screen/training_plan_top_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teaching Plan App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TrainingPlanListPage(),
        '/TrainingPlanTopPage': (context) => TrainingPlanTopPage(),
      },
    );
  }
}

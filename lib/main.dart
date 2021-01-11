import 'package:flutter/material.dart';
import 'package:order_form/common/theme.dart';
import 'package:order_form/import.dart';

void main() {
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();
NavigatorState get navigator => navigatorKey.currentState;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Form',
      navigatorKey: navigatorKey,
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: PreOrderScreen(),
    );
  }
}

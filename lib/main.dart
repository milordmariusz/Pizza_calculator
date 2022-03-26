import 'package:flutter/material.dart';
import 'package:pizza_calculator/form_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizza Calculator',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: formView(),
    );
  }
}
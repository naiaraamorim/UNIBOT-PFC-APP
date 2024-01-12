import 'package:flutter/material.dart';
import 'package:unibot_app/Screans/scream_chatbot.dart';
import 'package:unibot_app/Screans/scream_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreanChatbot(),
    );
  }
}

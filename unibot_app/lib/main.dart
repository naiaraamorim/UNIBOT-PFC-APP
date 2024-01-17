import 'package:flutter/material.dart';
import 'package:unibot_app/Screans/scream_chatbot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UNIBOT'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Colors.green,
        ),
        body: const ChatScreen(),
      ),
    );
  }
}

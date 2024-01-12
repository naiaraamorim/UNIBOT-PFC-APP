import 'package:flutter/material.dart';

class ScreanChatbot extends StatefulWidget {
  const ScreanChatbot({super.key});

  @override
  State<ScreanChatbot> createState() => _ScreanChatbotState();
}

class _ScreanChatbotState extends State<ScreanChatbot> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Chatbott')),
        body: Container(
          color: Colors.black,
        ),
      ),
    );
  }
}

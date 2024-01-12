import 'package:flutter/material.dart';

class ScreanChatbot extends StatefulWidget {
  const ScreanChatbot({super.key});

  @override
  State<ScreanChatbot> createState() => _ScreanChatbotState();
}

class _ScreanChatbotState extends State<ScreanChatbot> {
  TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UNIBOT'),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: ''),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            SizedBox(
              width: 100,
            ),
            TextField(
              controller: inputController,
            )
          ],
        ),
      ),
    );
  }
}

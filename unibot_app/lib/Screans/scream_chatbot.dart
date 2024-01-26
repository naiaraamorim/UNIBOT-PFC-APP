import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Defina a classe ChatMessage aqui
class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({Key? key, required this.text, required this.isUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isUser
              ? Expanded(
                  child: Container(),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 5.0),
                  child: const CircleAvatar(
                    child: Text('B'),
                  ),
                ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isUser
                        ? Colors.green
                        : Colors
                            .blue, // Escolha a cor do balão de acordo com o remetente
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          isUser
              ? Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  child: const CircleAvatar(
                    child: Text('U'),
                  ),
                )
              : Expanded(
                  child: Container(),
                ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  Future<void> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('http://192.168.18.13:5005/webhooks/rest/webhook'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'message': message}),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        _messages.add(ChatMessage(text: message, isUser: true));
        _messages
            .add(ChatMessage(text: responseData[0]['text'], isUser: false));
      });
    } else {
      throw Exception('Failed to send message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white12,
      child: Column(
        children: <Widget>[
          // Área de mensagens
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (_, index) => _messages[index],
            ),
          ),
          if (_messages.isEmpty)
            Container(
              height: 250,
              alignment: Alignment.topCenter,
              child: const Text(
                'Tire suas dúvidas sobre a instituição',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w100),
              ),
            ),
          // Área de entrada de texto
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8)),
              child: _buildTextComposer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    // Caixa de texto de entrada
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).canvasColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar uma mensagem',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.green,
              ),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    sendMessage(text);
  }
}

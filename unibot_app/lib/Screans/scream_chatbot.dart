import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isBotTyping = false;

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
          if (_isBotTyping)
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              alignment: Alignment.centerLeft,
              child: const Row(
                children: [
                  SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text('Bot digitando...'),
                ],
              ),
            ),
          if (_messages.isEmpty)
            Container(
              height: 250,
              alignment: Alignment.topCenter,
              child: const Text(
                'Tire suas dúvidas sobre a instituição',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
              ),
            ),
          // Área de entrada de texto
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  border:
                      Border.all(color: const Color.fromARGB(255, 5, 158, 7)),
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
                color: Color.fromARGB(255, 5, 158, 7),
              ),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitted(String text) async {
    _textController.clear();
    _addMessage(text, true);

    try {
      final response = await http.post(
        Uri.parse('http://192.168.18.13:5005/webhooks/rest/webhook'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'message': text}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _isBotTyping = true; // Ativar indicador de digitação do bot
        setState(() {});
        await Future.delayed(const Duration(seconds: 1)); // Simular digitação
        _addMessage(responseData[0]['text'], false);
        _isBotTyping = false; // Desativar indicador de digitação do bot
        setState(() {});
      } else {
        throw Exception('Failed to send message');
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  void _addMessage(String text, bool isUser) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: isUser));
    });
  }
}

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
                    // backgroundImage: NetworkImage(
                    //     'https://repository-images.githubusercontent.com/423180394/51fb7f2b-0bb0-4c3e-a06c-840fa3a910eb'),
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
                    color: isUser ? Colors.green : Colors.blue,
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

import 'package:flutter/material.dart';
import 'package:unibot_app/components/avatar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Área de mensagens
        Flexible(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            reverse: true,
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
        // Área centralizada de instruções se não houver mensagens

        // Área de entrada de texto
        const Divider(height: 1.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green[200],
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(8)),
            child: _buildTextComposer(),
          ),
        ),
      ],
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
    ChatMessage message = ChatMessage(
      text: text,
      isUser: true,
    );
    setState(() {
      _messages.insert(0, message);
    });

    // Aqui você pode adicionar lógica para responder ou processar a mensagem
  }
}

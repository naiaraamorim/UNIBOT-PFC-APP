import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // aqui seria tipo a busca no banco de dados com o usuário
          isUser
              ? Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    child: Text('U'),
                  ),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                isUser
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(bottom: 5.0),
                        child: const CircleAvatar(
                          child: Text('B'),
                        ),
                      ),
                Text(
                  text,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

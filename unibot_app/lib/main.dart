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
          centerTitle: true,
          title: const Text('UNIBOT'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: const IconThemeData(
              color: Colors.white), // Defina a cor do ícone aqui
          backgroundColor: Colors.green,
        ),
        drawer: Drawer(
          // Conteúdo do menu lateral
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 100,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Text(
                    'Menu Lateral',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Adicione aqui a lógica para lidar com o clique em Item 1
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Adicione aqui a lógica para lidar com o clique em Item 2
                },
              ),
              // Adicione mais itens do menu conforme necessário
            ],
          ),
        ),
        body: const ChatScreen(),
      ),
    );
  }
}

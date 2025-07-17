import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: const Color(0xFFE1BEE7),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 24),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Esta aplicación te permite ver chistes aleatorios de distintas categorías usando la JokeAPI.\n \nPuedes navegar entre chistes de Navidad, chistes oscuros y chistes de programación dantote la opcion de refrescar la lista en cualquier momento.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Desarrollada por Vicente Castillo.\n\n¡Disfruta y comparte una sonrisa!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
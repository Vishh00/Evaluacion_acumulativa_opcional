import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  bool _option1 = false;
  bool _option2 = false;
  bool _option3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: const Color(0xFFE1BEE7),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Preferencias',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CheckboxListTile(
                  title: const Text('Opción 1'),
                  value: _option1,
                  onChanged: (value) {
                    setState(() {
                      _option1 = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Opción 2'),
                  value: _option2,
                  onChanged: (value) {
                    setState(() {
                      _option2 = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Opción 3'),
                  value: _option3,
                  onChanged: (value) {
                    setState(() {
                      _option3 = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
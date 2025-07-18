import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';
import 'about.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {

  StartPage _startPage = HomePageState.startPage;

  @override
  void initState() {
    super.initState();
    _loadStartPage();
  }

  Future<void> _loadStartPage() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('startPage') ?? 0;
    setState(() {
      _startPage = StartPage.values[index];
    });
  }

  Future<void> _setStartPage(StartPage? value) async {
    if (value != null) {
      setState(() {
        _startPage = value;
        HomePageState.setStartPage(value);
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('startPage', value.index);
    }
  }
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
  /*
  Future<void> _openLinkPage() async {
     final Uri url = Uri.parse('https://v2.jokeapi.dev/');

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
    throw 'No se pudo abrir la página: $url';
    }
  }*/

  void _openAboutPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AboutPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: const Color(0xFFE1BEE7),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
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
                      const SizedBox(height: 24),
                      const Text(
                        'Página de inicio',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RadioListTile<StartPage>(
                        title: const Text('Random'),
                        value: StartPage.random,
                        groupValue: _startPage,
                        onChanged: _setStartPage,
                      ),
                      RadioListTile<StartPage>(
                        title: const Text('Navidad'),
                        value: StartPage.navidad,
                        groupValue: _startPage,
                        onChanged: _setStartPage,
                      ),
                      RadioListTile<StartPage>(
                        title: const Text('Dark'),
                        value: StartPage.dark,
                        groupValue: _startPage,
                        onChanged: _setStartPage,
                      ),
                      RadioListTile<StartPage>(
                        title: const Text('Programador'),
                        value: StartPage.programador,
                        groupValue: _startPage,
                        onChanged: _setStartPage,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.info, color: Colors.deepPurple),
                  title: const Text('Acerca de la app'),
                  onTap: _openAboutPage,
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.link, color: Colors.deepPurple),
                  title: const Text('Link a Jokes API'),
                  onTap: () => _launchInBrowser(Uri.parse('https://v2.jokeapi.dev/')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
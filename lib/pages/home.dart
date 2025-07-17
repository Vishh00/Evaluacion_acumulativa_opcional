import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/apiconectionrandom.dart';
import 'chistes_navidad.dart';
import 'chistes_dark.dart';
import 'chistes_programador.dart';
import 'config.dart';

enum StartPage { random, navidad, dark, programador }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static StartPage startPage = StartPage.random;

  static void setStartPage(StartPage page) {
    startPage = page;
  }

  @override
  void initState() {
    super.initState();
    _loadStartPage();
  }

  Future<void> _loadStartPage() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('startPage') ?? 0;
    setState(() {
      startPage = StartPage.values[index];
    });
  }

  int getInitialIndex() {
    switch (startPage) {
      case StartPage.random:
        return 0;
      case StartPage.navidad:
        return 1;
      case StartPage.dark:
        return 2;
      case StartPage.programador:
        return 3;
    }
  }

  void _openConfigPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ConfigPage()),
    ).then((_) => setState(() {})); // Refresca al volver de config
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: getInitialIndex(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE1BEE7),
        appBar: AppBar(
          title: const Text('Quick Jokes'),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Configuración',
              onPressed: _openConfigPage,
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,           // Letras seleccionadas blancas
            unselectedLabelColor: Colors.white, // Letras no seleccionadas blancas
            indicatorColor: Colors.white,       // Indicador blanco (opcional)
            tabs: [
              Tab(text: 'Random', icon: Icon(Icons.shuffle)),
              Tab(text: 'Navidad', icon: Icon(Icons.celebration)),
              Tab(text: 'Dark', icon: Icon(Icons.dark_mode)),
              Tab(text: 'Programador', icon: Icon(Icons.code)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CardsList(),
            ChistesNavidadPage(),
            ChistesDarkPage(),
            ChistesProgramadorPage(),
          ],
        ),
      ),
    );
  }
}

class CardsList extends StatefulWidget {
  const CardsList({Key? key}) : super(key: key);

  @override
  State<CardsList> createState() => CardsListState();
}

class CardsListState extends State<CardsList> {
  late Future<List<String>> jokesFuture;

  @override
  void initState() {
    super.initState();
    jokesFuture = fetchJokes();
  }

  void _refreshJokes() {
    setState(() {
      jokesFuture = fetchJokes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<String>>(
          future: jokesFuture,
            builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No se encontraron chistes.'));
            }
            final jokes = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(jokes[index]),
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: _refreshJokes,
            child: const Icon(Icons.refresh),
            tooltip: 'Actualizar chistes',
          ),
        ),
      ],
    );
  }
}
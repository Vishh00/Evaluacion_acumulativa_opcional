import 'package:flutter/material.dart';
import '../services/apiconectionprograming.dart';

class ChistesProgramadorPage extends StatefulWidget {
  const ChistesProgramadorPage({Key? key}) : super(key: key);

  @override
  State<ChistesProgramadorPage> createState() => _ChistesProgramadorPageState();
}

class _ChistesProgramadorPageState extends State<ChistesProgramadorPage> {
  late Future<List<String>> jokesFuture;

  @override
  void initState() {
    super.initState();
    jokesFuture = fetchProgrammingJokes();
  }

  void _refreshJokes() {
    setState(() {
      jokesFuture = fetchProgrammingJokes();
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
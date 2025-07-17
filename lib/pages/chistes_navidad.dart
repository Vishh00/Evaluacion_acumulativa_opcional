import 'package:flutter/material.dart';
import '../services/apiconectionnavidad.dart';

class ChistesNavidadPage extends StatefulWidget {
  const ChistesNavidadPage({Key? key}) : super(key: key);

  @override
  State<ChistesNavidadPage> createState() => _ChistesNavidadPageState();
}

class _ChistesNavidadPageState extends State<ChistesNavidadPage> {
  late Future<List<String>> chistesnavidad;

  @override
  void initState() {
    super.initState();
    chistesnavidad = fetchChistesNavidad();
  }

  void _refreshChistes() {
    setState(() {
      chistesnavidad = fetchChistesNavidad();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<String>>(
          future: chistesnavidad,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No se encontraron chistes.'));
            }
            final chistes = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: chistes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      chistes[index],
                      style: const TextStyle(fontSize: 16),
                    ),
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
            onPressed: _refreshChistes,
            child: const Icon(Icons.refresh),
            tooltip: 'Actualizar chistes',
          ),
        ),
      ],
    );
  }
}
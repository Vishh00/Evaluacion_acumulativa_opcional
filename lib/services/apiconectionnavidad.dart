import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchChistesNavidad() async {
  final url = Uri.parse('https://v2.jokeapi.dev/joke/Christmas?type=twopart&amount=10');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = json.decode(response.body); 
    final List rawJokesList = data['jokes'] as List;
    final List<String> chistes = [];
    for (var jokeData in rawJokesList) {
        if (jokeData is! Map<String, dynamic>) {
          continue;
        }
        final String setup = (jokeData['setup'] is String)
              ? (jokeData['setup'] as String)
              : 'Parte inicial no disponible.';
        final String delivery = (jokeData['delivery'] is String)
              ? (jokeData['delivery'] as String)
              : 'Parte final no disponible.';
        chistes.add('$setup\n$delivery');
      }
    return chistes;
  } else {
    throw Exception('Error al cargar chistes');
  }
}
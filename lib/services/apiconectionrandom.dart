import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchJokes() async {
  final url = Uri.parse('https://v2.jokeapi.dev/joke/Any?type=single&amount=10');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final jokes = (data['jokes'] as List)
        .map<String>((joke) => joke['joke'] as String)
        .toList();
    return jokes;
  } else {
    throw Exception('Error al cargar chistes');
  }
}
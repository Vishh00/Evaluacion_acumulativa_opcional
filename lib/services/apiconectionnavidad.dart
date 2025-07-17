import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchChistesNavidad() async {
  final url = Uri.parse('https://v2.jokeapi.dev/joke/Christmas?type=single&amount=10');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final chistes = (data['jokes'] as List)
        .map<String>((joke) => joke['joke'] as String)
        .toList();
    return chistes;
  } else {
    throw Exception('Error al cargar chistes de Navidad');
  }
}
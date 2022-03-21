import 'package:http/http.dart ' as http;

String url = 'https://valorant-api.com/v1';

class Services {
  Future<dynamic> getAgents() async {
    final response =
        await http.get(Uri.parse('$url/agents?language=es-ES'), headers: {
      'Content-Type': 'application/json',
      'data': ['data'].toString(),
    });

    return response;
  }
}

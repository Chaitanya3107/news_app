import 'package:http/http.dart' as http;

class APIService {
  final endpoint = 'newsapi.org';

  final client = http.Client();

  Future<http.Response> getArticle() async {
    final uri = Uri.parse(
        'https://newsapi.org/v2/everything?q=bitcoin&apiKey=92aed2a8bfb04e7d83da077e682c5f0f');
    final response = await client.get(uri);
    return response;
  }
}

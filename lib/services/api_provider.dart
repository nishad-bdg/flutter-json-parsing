import 'dart:convert';
import 'package:bloc_json/models/api_model.dart';
import 'package:http/http.dart' as http;

class ArticleApiProvider {
  final String baseUrl =
      'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=ca7e723f9ed646a4939a4d65f566df94';
  Future<List<Articles>> getArticles() async {
    final response = await http.get(baseUrl);
    final responseString = jsonDecode(response.body);
    print(responseString);
    if (response.statusCode == 200) {
      return ApiResult.fromJson(responseString).articles;
    } else {
      throw Exception("Failed to load data");
    }
  }
} //class ends here

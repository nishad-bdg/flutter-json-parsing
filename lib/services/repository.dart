import 'package:bloc_json/models/api_model.dart';
import 'package:bloc_json/services/api_provider.dart';

class ArticleRepository {
  final ArticleApiProvider _articleApiProvider = ArticleApiProvider();

  Future<List<Articles>> getArticles() => _articleApiProvider.getArticles();
}

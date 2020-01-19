import 'package:bloc_json/models/api_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ArticleState {}

class InitialArticleState extends ArticleState {}

class ArticleFetchingState extends ArticleState {}

class ArticleFetchedState extends ArticleState {
  final List<Articles> articles;
  ArticleFetchedState({@required this.articles}) : assert(articles != null);
}

class ArticleFetchErrorState extends ArticleState {
  final String message;
  ArticleFetchErrorState({@required this.message}) : assert(message != null);
}

class ArticleFetchEmptyState extends ArticleState {}

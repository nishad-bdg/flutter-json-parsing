import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_json/models/api_model.dart';
import 'package:bloc_json/services/repository.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc({@required this.articleRepository}) : assert(articleRepository != null);

  @override
  ArticleState get initialState => InitialArticleState();

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    if (event is FetchArticleEvent) {
      yield ArticleFetchingState();
      try {
        final List<Articles> articles = await articleRepository.getArticles();
        yield ArticleFetchedState(articles: articles);
      } catch (e) {
        yield ArticleFetchErrorState(message: e.toString());
      }
    }
  }
}

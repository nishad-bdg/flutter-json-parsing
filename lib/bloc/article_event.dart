import 'package:meta/meta.dart';

@immutable
abstract class ArticleEvent {}

class FetchArticleEvent extends ArticleEvent {}

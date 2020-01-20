import 'package:bloc_json/bloc/bloc.dart';
import 'package:bloc_json/models/api_model.dart';
import 'package:bloc_json/pages/AboutPage.dart';
import 'package:bloc_json/pages/ArticleDetailsPage.dart';
import 'package:bloc_json/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final ArticleRepository articleRepository;
  HomePage({this.articleRepository});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleBloc articleBloc;
  
  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Cricket"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      debugPrint("Refresh Button Pressed data loaded");
                      articleBloc.add(FetchArticleEvent());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      debugPrint("Info");
                      navigateToAboutPage(context);
                    },
                  ),
                ],
              ),
              body: Container(
                child: BlocListener<ArticleBloc, ArticleState>(
                  listener: (context, state) {
                    if (state is ArticleFetchErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      if (state is InitialArticleState) {
                        return buildLoading();
                      } else if (state is ArticleFetchingState) {
                        return buildLoading();
                      } else if (state is ArticleFetchedState) {
                        return buildArticleList(state.articles);
                      } else if (state is ArticleFetchErrorState) {
                        return buildErrorUi(state.message);
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: ListTile(
                leading: ClipOval(
                  child: Hero(
                    tag: articles[index].urlToImage,
                    child: Image.network(
                      articles[index].urlToImage,
                      fit: BoxFit.cover,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                title: Text(articles[index].title),
                subtitle: Text(articles[index].publishedAt),
              ),
              onTap: () {
                navigateToArticleDetailPage(context, articles[index]);
                debugPrint("Hello");
              },
            ),
          );
        });
  }

  void navigateToArticleDetailPage(BuildContext context, Articles article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(article: article);
    }));
  }

  void navigateToAboutPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AboutPage();
    }));
  }
} // class ends here

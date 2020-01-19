import 'package:bloc_json/bloc/bloc.dart';
import 'package:bloc_json/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/HomePage.dart';

void main() {
  final ArticleRepository _articleRepository = ArticleRepository();
  runApp(MyApp(articleRepository: _articleRepository));
}

class MyApp extends StatelessWidget {
  final ArticleRepository articleRepository;
  MyApp({this.articleRepository});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (BuildContext context) =>
            ArticleBloc(articleRepository: articleRepository),
        child: HomePage(articleRepository: articleRepository),
      ),
    );
  }
}

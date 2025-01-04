import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme/app_themes.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'features/daily_news/presentation/screens/article_detail/article_detail.dart';
import 'features/daily_news/presentation/screens/home/daily_news.dart';
import 'features/daily_news/presentation/screens/saved_articles/saved_articles.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => serviceLocator()..add(const GetArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Go Healing',
        theme: theme(),
        initialRoute: '/daily-news',
        routes: {
          '/daily-news': (context) => const DailyNewsScreen(),
          '/article-detail': (context) => const ArticleDetailScreen(),
          '/saved-articles': (context) => const SavedArticlesScreen(),
        },
      ),
    );
  }
}

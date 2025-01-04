import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/show_snackbar.dart';
import '../../../domain/entities/article.dart';
import '../../bloc/article/local/local_article_bloc.dart';
import '../../bloc/article/local/local_article_event.dart';
import '../../../../../injection_container.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late ArticleEntity article;
  late bool isSaved;

  @override
  Widget build(BuildContext context) {
    final arguments = ArticleDetailScreenArguments.fromMap(
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
    );

    article = arguments.article;
    isSaved = arguments.isSaved;

    return BlocProvider(
      create: (_) => serviceLocator<LocalArticleBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Article Detail',
          ),
        ),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            article.title ?? '',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          // Date
          Row(
            children: [
              const Icon(Icons.timeline_outlined, size: 16),
              const SizedBox(width: 4),
              Text(
                article.publishedAt!,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    if (article.urlToImage == '') {
      return Container(
        width: double.maxFinite,
        height: 250,
        margin: const EdgeInsets.only(top: 14),
        color: Colors.black.withAlpha(8),
        child: const Icon(Icons.error),
      );
    }
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(
        article.urlToImage!,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Text(
        '${article.description ?? ''}\n \n${article.content ?? ''}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(builder: (context) {
      return FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: Icon(
          isSaved ? Icons.remove_circle_outline : Icons.bookmark_outline,
          color: Colors.white,
        ),
      );
    });
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    if (isSaved) {
      context.read<LocalArticleBloc>().add(DeleteArticle(article));
      Navigator.pop(context);
      showSnackbar(context, 'Article removed from saved');
    } else {
      context.read<LocalArticleBloc>().add(SaveArticle(article));
    }
  }
}

class ArticleDetailScreenArguments {
  final ArticleEntity article;
  final bool isSaved;

  ArticleDetailScreenArguments({
    required this.article,
    required this.isSaved,
  });

  factory ArticleDetailScreenArguments.fromMap(Map<String, dynamic> map) {
    return ArticleDetailScreenArguments(
      article: map['article'],
      isSaved: map['isSaved'],
    );
  }
}

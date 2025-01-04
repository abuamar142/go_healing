import 'package:equatable/equatable.dart';
import '../../../../domain/entities/article.dart';

abstract class LocalArticleEvent extends Equatable {
  final ArticleEntity? article;

  const LocalArticleEvent({this.article});

  @override
  List<Object> get props => [article!];
}

class GetSavedArticle extends LocalArticleEvent {
  const GetSavedArticle();
}

class SaveArticle extends LocalArticleEvent {
  const SaveArticle(ArticleEntity article) : super(article: article);
}

class DeleteArticle extends LocalArticleEvent {
  const DeleteArticle(ArticleEntity article) : super(article: article);
}

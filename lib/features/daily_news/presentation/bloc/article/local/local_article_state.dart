import 'package:equatable/equatable.dart';
import '../../../../domain/entities/article.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articles;

  const LocalArticleState({this.articles});

  @override
  List<Object> get props => [articles!];
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleSuccess extends LocalArticleState {
  const LocalArticleSuccess({
    super.articles,
  });
}

import '../../../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repository/article_repository.dart';

class SaveArticleUseCase implements Usecase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  SaveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.saveArticle(params!);
  }
}

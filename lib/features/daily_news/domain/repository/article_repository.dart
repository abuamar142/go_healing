import '../../../../core/resources/data_state.dart';
import '../entities/article.dart';

abstract class ArticleRepository {
  // Remote data source
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  // Local data source
  Future<List<ArticleEntity>> getSavedArticles();
  Future<void> saveArticle(ArticleEntity article);
  Future<void> deleteArticle(ArticleEntity article);
}

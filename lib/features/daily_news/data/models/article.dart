import 'package:floor/floor.dart';
import '../../domain/entities/article.dart';

class ArticleResponseModel {
  List<ArticleModel> articles;

  ArticleResponseModel({required this.articles});

  factory ArticleResponseModel.fromJson(
    Map<String, dynamic> articleResponseData,
  ) {
    return ArticleResponseModel(
      articles: ((articleResponseData['articles'] ?? []) as List<dynamic>)
          .map((dynamic article) => ArticleModel.fromJson(article))
          .toList(),
    );
  }
}

@Entity(tableName: 'articles', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    super.id,
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> articleModelData) {
    return ArticleModel(
      author: articleModelData['author'] ?? "",
      title: articleModelData['title'] ?? "",
      description: articleModelData['description'] ?? "",
      url: articleModelData['url'] ?? "",
      urlToImage: articleModelData['urlToImage'] ?? "",
      publishedAt: articleModelData['publishedAt'] ?? "",
      content: articleModelData['content'] ?? "",
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity articleEntity) {
    return ArticleModel(
      id: articleEntity.id,
      author: articleEntity.author,
      title: articleEntity.title,
      description: articleEntity.description,
      url: articleEntity.url,
      urlToImage: articleEntity.urlToImage,
      publishedAt: articleEntity.publishedAt,
      content: articleEntity.content,
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/delete_article.dart';
import '../../../../domain/usecases/get_saved_article.dart';
import '../../../../domain/usecases/save_article.dart';
import 'local_article_event.dart';
import 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;

  LocalArticleBloc(
    this._getSavedArticleUseCase,
    this._saveArticleUseCase,
    this._deleteArticleUseCase,
  ) : super(const LocalArticleLoading()) {
    on<GetSavedArticle>(onGetSavedArticles);
    on<SaveArticle>(onSaveArticle);
    on<DeleteArticle>(onDeleteArticle);
  }

  void onGetSavedArticles(
      GetSavedArticle event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleSuccess(articles: articles));
  }

  void onSaveArticle(
    SaveArticle saveArticle,
    Emitter<LocalArticleState> emit,
  ) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleSuccess(articles: articles));
  }

  void onDeleteArticle(
    DeleteArticle deleteArticle,
    Emitter<LocalArticleState> emit,
  ) async {
    await _deleteArticleUseCase(params: deleteArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleSuccess(articles: articles));
  }
}

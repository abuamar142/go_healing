import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'features/daily_news/data/data_sources/local/app_database.dart';
import 'features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'features/daily_news/data/repository/article_repository_impl.dart';
import 'features/daily_news/domain/repository/article_repository.dart';
import 'features/daily_news/domain/usecases/delete_article.dart';
import 'features/daily_news/domain/usecases/get_article.dart';
import 'features/daily_news/domain/usecases/get_saved_article.dart';
import 'features/daily_news/domain/usecases/save_article.dart';
import 'features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  final database = await $FloorAppDatabase
      .databaseBuilder(
        'app_database.db',
      )
      .build();

  serviceLocator
    ..registerSingleton<AppDatabase>(database)

    // Dio
    ..registerSingleton<Dio>(Dio())

    // Dependencies
    ..registerSingleton<NewsApiService>(
      NewsApiService(serviceLocator()),
    )

    // Repositories
    ..registerSingleton<ArticleRepository>(
      ArticleRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )

    // UseCases
    ..registerSingleton<GetArticleUseCase>(
      GetArticleUseCase(serviceLocator()),
    )
    ..registerSingleton<GetSavedArticleUseCase>(
      GetSavedArticleUseCase(
        serviceLocator(),
      ),
    )
    ..registerSingleton<SaveArticleUseCase>(
      SaveArticleUseCase(
        serviceLocator(),
      ),
    )
    ..registerSingleton<DeleteArticleUseCase>(
      DeleteArticleUseCase(
        serviceLocator(),
      ),
    )

    // Blocs
    ..registerFactory<RemoteArticleBloc>(
      () => RemoteArticleBloc(serviceLocator()),
    )
    ..registerFactory<LocalArticleBloc>(
      () => LocalArticleBloc(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
}

import 'package:dio/dio.dart';
import 'package:egypto/features/home/data/repository_impl/quick_prompts.dart';
import 'package:get_it/get_it.dart';
import '../../../features/home/domain/repositories/quick_prompts.dart';
import '../../../features/home/data/datasource/quick_prompts.dart';

class QuickPromptsDependencies {
  static void register() {
    GetIt.I.registerLazySingleton<QuickPromptsApiService>(
      () => QuickPromptsApiService(
        GetIt.I<Dio>(),
        baseUrl: '${GetIt.I<Dio>().options.baseUrl}quick-prompts',
      ),
    );

    GetIt.I.registerLazySingleton<QuickPromptsRepository>(
      () => QuickPromptsRepositoryImpl(GetIt.I<QuickPromptsApiService>()),
    );
  }
}

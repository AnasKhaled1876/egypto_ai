import 'package:dio/dio.dart';
import 'package:egypto/features/chat/domain/repositories/chat.dart';
import 'package:egypto/features/chat/data/repository_impl/chat.dart';
import 'package:get_it/get_it.dart';

import '../../../features/chat/data/datasource/chat.dart';


class ChatDependencies {
  static void register() {
    GetIt.I.registerLazySingleton<ChatApiService>(
      () => ChatApiService(
        GetIt.I<Dio>(),
        baseUrl: '${GetIt.I<Dio>().options.baseUrl}chat',
      ),
    );

    GetIt.I.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(GetIt.I<ChatApiService>()),
    );
  }
}

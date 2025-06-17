import 'package:egypto_ai/data/base_api_repository.dart';
import 'package:egypto_ai/data/datasources/remote/quick_prompts.dart';
import 'package:egypto_ai/data/resources/data_state.dart';
import 'package:egypto_ai/domain/responses/quick_prompts.dart';

import '../../domain/repositories/quick_prompts.dart';

class QuickPromptsRepositoryImpl extends BaseApiRepository
    implements QuickPromptsRepository {
  final QuickPromptsApiService _quickPromptsApiService;
  QuickPromptsRepositoryImpl(this._quickPromptsApiService);

  @override
  Future<DataState<GetQuickPromptsResponse>> getQuickPrompts() {
    return getStateOf<GetQuickPromptsResponse>(
      request: () => _quickPromptsApiService.getQuickPrompts(),
    );
  }
}

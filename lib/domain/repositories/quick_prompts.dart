import 'package:egypto_ai/data/resources/data_state.dart';
import 'package:egypto_ai/domain/responses/quick_prompts.dart';

abstract class QuickPromptsRepository {
  Future<DataState<GetQuickPromptsResponse>> getQuickPrompts();
}

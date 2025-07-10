import 'package:egypto/core/data_state.dart';
import 'package:egypto/domain/responses/quick_prompts.dart';

abstract class QuickPromptsRepository {
  Future<DataState<GetQuickPromptsResponse>> getQuickPrompts();
}

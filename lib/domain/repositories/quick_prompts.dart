import 'package:egypto/data/resources/data_state.dart';
import 'package:egypto/domain/responses/quick_prompts.dart';

abstract class QuickPromptsRepository {
  Future<DataState<GetQuickPromptsResponse>> getQuickPrompts();
}

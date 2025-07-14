import 'package:egypto/core/data_state.dart';
import 'package:egypto/features/home/data/models/get_quick_prompts_response.dart';

abstract class QuickPromptsRepository {
  Future<DataState<GetQuickPromptsResponse>> getQuickPrompts();
}

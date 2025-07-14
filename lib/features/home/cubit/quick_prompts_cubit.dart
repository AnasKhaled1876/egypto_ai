import 'package:bloc/bloc.dart';
import 'package:egypto/features/home/data/models/quick_prompt.dart';
import 'package:equatable/equatable.dart';

import '../../../core/data_state.dart';
import '../domain/repositories/quick_prompts.dart';

part 'quick_prompts_state.dart';

class QuickPromptsCubit extends Cubit<QuickPromptsState> {
  QuickPromptsCubit(this._quickPromptsRepository)
    : super(QuickPromptsInitial());
  final QuickPromptsRepository _quickPromptsRepository;

  List<QuickPrompt> quickPrompts = [];

  Future<void> getQuickPrompts() async {
    if (quickPrompts.isNotEmpty || state is QuickPromptsLoading) return;
    emit(QuickPromptsLoading());
    final result = await _quickPromptsRepository.getQuickPrompts();
    if (result is DataSuccess) {
      quickPrompts = result.data?.data ?? [];
      emit(QuickPromptsSuccess());
    } else if (result is DataFailed) {
      emit(QuickPromptsFailure(result.error?.message ?? 'An error occurred'));
    }
  }
}

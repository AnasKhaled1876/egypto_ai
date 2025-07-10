part of 'quick_prompts_cubit.dart';

sealed class QuickPromptsState extends Equatable {
  const QuickPromptsState();

  @override
  List<Object> get props => [];
}

final class QuickPromptsInitial extends QuickPromptsState {}

final class QuickPromptsLoading extends QuickPromptsState {}

final class QuickPromptsSuccess extends QuickPromptsState {}

final class QuickPromptsFailure extends QuickPromptsState {
  final String error;
  const QuickPromptsFailure(this.error);
}

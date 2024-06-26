part of 'feedback_cubit.dart';

enum FeedbackEvents {
  start,
  success,
  failure,
}

@immutable
class FeedbackState {
  final bool loading;
  final FeedbackEvents? event;
  final ExceptionModel? exception;

  const FeedbackState({
    this.event,
    this.exception,
    required this.loading,
  });

  FeedbackState copyWith({
    bool? loading,
    FeedbackEvents? event,
    ExceptionModel? exception,
  }) {
    return FeedbackState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      exception: exception ?? this.exception,
    );
  }

  factory FeedbackState.unknown() {
    return const FeedbackState(loading: false);
  }
}

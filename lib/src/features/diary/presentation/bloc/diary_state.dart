part of 'diary_bloc.dart';

@immutable
class DiaryState extends Equatable {
  const DiaryState({
    this.diary = const Diary.initial(),
    this.status = Status.initial,
    this.statusMessage,
    this.isLoading = false,
    this.isDiaryFieldsIncomplete = true,
  });

  final Diary diary;
  final Status status;
  final String? statusMessage;
  final bool isLoading;
  final bool isDiaryFieldsIncomplete;

  DiaryState copyWith({
    Diary? diary,
    Status? status,
    String? statusMessage,
    bool? isLoading,
    bool? isDiaryFieldsIncomplete,
  }) {
    return DiaryState(
      diary: diary ?? this.diary,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      isLoading: isLoading ?? this.isLoading,
      isDiaryFieldsIncomplete:
          isDiaryFieldsIncomplete ?? this.isDiaryFieldsIncomplete,
    );
  }

  @override
  String toString() {
    return '''DiaryState { diary: $diary, status: $status, statusMessage: $statusMessage, isLoading: $isLoading, isDiaryFieldsIncomplete: $isDiaryFieldsIncomplete }''';
  }

  @override
  List<Object?> get props => [
        diary,
        status,
        statusMessage,
        isLoading,
        isDiaryFieldsIncomplete,
      ];
}

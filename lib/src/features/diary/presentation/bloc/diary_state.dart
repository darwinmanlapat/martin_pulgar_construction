part of 'diary_bloc.dart';

@immutable
class DiaryState extends Equatable {
  const DiaryState({
    this.files = const [],
    this.comment,
    this.date,
    this.tags,
    this.area,
    this.category,
    this.event,
    this.status = Status.initial,
    this.statusMessage,
  });

  final List<File> files;
  final String? comment;
  final String? date;
  final String? tags;
  final String? area;
  final String? category;
  final String? event;
  final Status status;
  final String? statusMessage;

  DiaryState copyWith({
    List<File>? files,
    String? comment,
    String? date,
    String? tags,
    String? area,
    String? category,
    String? event,
    Status? status,
    String? statusMessage,
  }) {
    return DiaryState(
      files: files ?? this.files,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      tags: tags ?? this.tags,
      area: area ?? this.area,
      category: category ?? this.category,
      event: event ?? this.event,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  String toString() {
    return '''DiaryState { files: ${files.length}, comment: $comment, date: $date, tags: $tags, area: $area, category: $category, event: $event status: $status, statusMessage: $statusMessage }''';
  }

  @override
  List<Object?> get props => [
        files.length,
        comment,
        date,
        tags,
        area,
        category,
        event,
        status,
        statusMessage
      ];
}

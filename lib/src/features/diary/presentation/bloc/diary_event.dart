part of 'diary_bloc.dart';

@immutable
abstract class DiaryEvent extends Equatable {
  @override
  List<Object?> get props => ['comment'];
}

class AddDiaryPhotos extends DiaryEvent {
  @override
  List<Object?> get props => [];
}

class RemoveDiaryPhoto extends DiaryEvent {
  final int index;

  RemoveDiaryPhoto(this.index);

  @override
  List<Object?> get props => [index];
}

class CommentFieldChanged extends DiaryEvent {
  final String text;

  CommentFieldChanged(this.text);

  @override
  List<Object?> get props => [text];
}

class TagsFieldChanged extends DiaryEvent {
  final String text;

  TagsFieldChanged(this.text);

  @override
  List<Object?> get props => [text];
}

class DateFieldChanged extends DiaryEvent {
  final String text;

  DateFieldChanged(this.text);

  @override
  List<Object?> get props => [text];
}

class AreaFieldChanged extends DiaryEvent {
  final String text;

  AreaFieldChanged(this.text);

  @override
  List<Object?> get props => [text];
}

class CategoryFieldChanged extends DiaryEvent {
  final String text;

  CategoryFieldChanged(this.text);

  @override
  List<Object?> get props => [text];
}

class EventFieldChanged extends DiaryEvent {
  final String text;

  EventFieldChanged(this.text);

  @override
  List<Object?> get props => [text];
}

class DiaryFieldsCheck extends DiaryEvent {
  @override
  List<Object?> get props => [];
}

class SubmitDiary extends DiaryEvent {
  @override
  List<Object?> get props => [];
}

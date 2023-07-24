import 'dart:io';

import 'package:equatable/equatable.dart';

class Diary extends Equatable {
  final List<File>? files;
  final String? comment;
  final String? date;
  final String? tags;
  final String? area;
  final String? category;
  final String? event;

  const Diary({
    this.files,
    this.comment,
    this.date,
    this.tags,
    this.area,
    this.category,
    this.event,
  });

  const Diary.initial()
      : files = null,
        comment = null,
        date = null,
        tags = null,
        area = null,
        category = null,
        event = null;

  @override
  List<Object?> get props => [
        files?.length,
        comment,
        date,
        tags,
        area,
        category,
        event,
      ];
}

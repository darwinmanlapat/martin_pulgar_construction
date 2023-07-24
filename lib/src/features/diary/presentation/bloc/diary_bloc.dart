import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:martin_pulgar_construction/src/enum/enum.dart';
import 'package:martin_pulgar_construction/src/features/diary/domain/model/model.dart';
import 'package:martin_pulgar_construction/src/features/diary/domain/repository/repository.dart';
import 'package:permission_handler/permission_handler.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc({required this.repository}) : super(const DiaryState()) {
    on<AddDiaryPhotos>(_onAddDiaryPhotos);
    on<RemoveDiaryPhoto>(_onRemoveDiaryPhoto);
    on<CommentFieldChanged>(_onCommentFieldChanged);
    on<DateFieldChanged>(_onDateFieldChanged);
    on<AreaFieldChanged>(_onAreaFieldChanged);
    on<CategoryFieldChanged>(_onCategoryFieldChanged);
    on<TagsFieldChanged>(_onTagsFieldChanged);
    on<EventFieldChanged>(_onEventFieldChanged);
    on<SubmitDiary>(_onSubmitDiary);
    on<DiaryFieldsCheck>(_onFieldCheck);
  }

  final DiaryRepository repository;

  Future<void> _onSubmitDiary(
      SubmitDiary event, Emitter<DiaryState> emit) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
      final response = await repository.submitDiary(state.diary);

      if (response == true) {
        emit(
          state.copyWith(
            status: Status.success,
            isLoading: false,
            isDiaryFieldsIncomplete: true,
            statusMessage: null,
            diary: const Diary.initial(),
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          statusMessage: e.toString(),
        ),
      );
    }
  }

  void _onFieldCheck(
    DiaryFieldsCheck event,
    Emitter<DiaryState> emit,
  ) {
    if (state.diary.files == null ||
        state.diary.comment == null ||
        state.diary.date == null ||
        state.diary.area == null ||
        state.diary.category == null ||
        state.diary.tags == null ||
        state.diary.event == null ||
        state.diary.files!.isEmpty ||
        state.diary.comment!.isEmpty ||
        state.diary.date!.isEmpty ||
        state.diary.area!.isEmpty ||
        state.diary.category!.isEmpty ||
        state.diary.tags!.isEmpty ||
        state.diary.event!.isEmpty) {
      emit(
        state.copyWith(
          isDiaryFieldsIncomplete: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isDiaryFieldsIncomplete: false,
        ),
      );
    }
  }

  Future<void> _onAddDiaryPhotos(
      AddDiaryPhotos event, Emitter<DiaryState> emit) async {
    try {
      await Permission.photos.request().isGranted;
      List<File> images = [];
      final pickedImages = await ImagePicker().pickMultiImage();

      for (var pickedImage in pickedImages) {
        final image = File(pickedImage.path);
        images.add(image);
      }

      emit(
        state.copyWith(
          diary: Diary(
            files: [...?state.diary.files, ...images],
            comment: state.diary.comment,
            date: state.diary.date,
            area: state.diary.area,
            category: state.diary.category,
            tags: state.diary.tags,
            event: state.diary.event,
          ),
        ),
      );
    } on PlatformException catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          statusMessage: e.message,
        ),
      );
    }
  }

  void _onRemoveDiaryPhoto(RemoveDiaryPhoto event, Emitter<DiaryState> emit) {
    try {
      List<File> updatedList = List.from(state.diary.files!.toList());
      if (event.index >= 0 && event.index < updatedList.length) {
        updatedList.removeAt(event.index);
        emit(
          state.copyWith(
            diary: Diary(
              files: updatedList,
              comment: state.diary.comment,
              date: state.diary.date,
              area: state.diary.area,
              category: state.diary.category,
              tags: state.diary.tags,
              event: state.diary.event,
            ),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          statusMessage: 'Unable to remove photo',
        ),
      );
    }
  }

  void _onCommentFieldChanged(
      CommentFieldChanged event, Emitter<DiaryState> emit) {
    try {
      emit(
        state.copyWith(
          diary: Diary(
            files: state.diary.files,
            comment: event.text,
            date: state.diary.date,
            area: state.diary.area,
            category: state.diary.category,
            tags: state.diary.tags,
            event: state.diary.event,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          statusMessage: 'Unable to add comment',
        ),
      );
    }
  }

  void _onDateFieldChanged(DateFieldChanged event, Emitter<DiaryState> emit) {
    try {
      emit(
        state.copyWith(
          diary: Diary(
            files: state.diary.files,
            comment: state.diary.comment,
            date: event.text,
            area: state.diary.area,
            category: state.diary.category,
            tags: state.diary.tags,
            event: state.diary.event,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          statusMessage: 'Unable to add date',
        ),
      );
    }
  }

  void _onAreaFieldChanged(AreaFieldChanged event, Emitter<DiaryState> emit) {
    try {
      emit(
        state.copyWith(
          diary: Diary(
            files: state.diary.files,
            comment: state.diary.comment,
            date: state.diary.date,
            area: event.text,
            category: state.diary.category,
            tags: state.diary.tags,
            event: state.diary.event,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          statusMessage: 'Unable to add area',
        ),
      );
    }
  }

  void _onCategoryFieldChanged(
      CategoryFieldChanged event, Emitter<DiaryState> emit) {
    try {
      emit(
        state.copyWith(
          diary: Diary(
            files: state.diary.files,
            comment: state.diary.comment,
            date: state.diary.date,
            area: state.diary.area,
            category: event.text,
            tags: state.diary.tags,
            event: state.diary.event,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          statusMessage: 'Unable to add category',
        ),
      );
    }
  }

  void _onTagsFieldChanged(TagsFieldChanged event, Emitter<DiaryState> emit) {
    try {
      emit(
        state.copyWith(
          diary: Diary(
            files: state.diary.files,
            comment: state.diary.comment,
            date: state.diary.date,
            area: state.diary.area,
            category: state.diary.category,
            tags: event.text,
            event: state.diary.event,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          statusMessage: 'Unable to add tags',
        ),
      );
    }
  }

  void _onEventFieldChanged(EventFieldChanged event, Emitter<DiaryState> emit) {
    try {
      emit(
        state.copyWith(
          diary: Diary(
            files: state.diary.files,
            comment: state.diary.comment,
            date: state.diary.date,
            area: state.diary.area,
            category: state.diary.category,
            tags: state.diary.tags,
            event: event.text,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          statusMessage: 'Unable to add event',
        ),
      );
    }
  }
}

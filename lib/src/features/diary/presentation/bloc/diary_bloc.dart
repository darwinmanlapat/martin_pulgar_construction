import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:martin_pulgar_construction/src/enum/enum.dart';
import 'package:permission_handler/permission_handler.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc() : super(const DiaryState()) {
    on<AddDiaryPhotos>(_onAddDiaryPhotos);
    on<RemoveDiaryPhoto>(_onRemoveDiaryPhoto);
    on<CommentFieldChanged>(_onCommentFieldChanged);
    on<DateFieldChanged>(_onDateFieldChanged);
    on<AreaFieldChanged>(_onAreaFieldChanged);
    on<CategoryFieldChanged>(_onCategoryFieldChanged);
    on<TagsFieldChanged>(_onTagsFieldChanged);
    on<EventFieldChanged>(_onEventFieldChanged);
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
          status: Status.success,
          files: [...state.files, ...images],
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
      List<File> updatedList = List.from(state.files);
      if (event.index >= 0 && event.index < updatedList.length) {
        updatedList.removeAt(event.index);
        emit(state.copyWith(status: Status.success, files: updatedList));
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
      emit(state.copyWith(status: Status.success, comment: event.text));
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
      emit(state.copyWith(status: Status.success, date: event.text));
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
      emit(state.copyWith(status: Status.success, area: event.text));
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
      emit(state.copyWith(status: Status.success, category: event.text));
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
      emit(state.copyWith(status: Status.success, tags: event.text));
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
      emit(state.copyWith(status: Status.success, event: event.text));
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

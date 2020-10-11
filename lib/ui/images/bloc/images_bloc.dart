import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:images_app/domain/index.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final ImagesRepo imagesRepo;
  final SuggestionsRepo suggestionsRepo;

  ImagesBloc({
    @required this.imagesRepo,
    @required this.suggestionsRepo,
  }) : super(ImagesState.loading());

  @override
  Stream<ImagesState> mapEventToState(
    ImagesEvent event,
  ) async* {
    final itemsPerPage = imagesRepo.itemsPerPage;
    if (event is ImagesEventInitialLoad) {
      yield ImagesState.loading();
      try {
        final images = await imagesRepo.search(query: event.query);
        if (images != null && images.isNotEmpty) {
          if (event.query != null && event.query.trim().isNotEmpty) {
            suggestionsRepo.add(event.query);
          }
          final hasNextPage = images.length >= itemsPerPage;
          yield ImagesState.success(
            images: images,
            hasNextPage: hasNextPage,
            query: event.query,
          );
        } else {
          yield ImagesState.empty();
        }
      } catch (e) {
        print(e);
        yield ImagesState.error('Failed to get images');
      }
    }

    if (event is ImagesEventLoadNextPage) {
      yield state.copyWith(isLoadingNextPage: true);
      final prevImages = state.images;
      final page = (prevImages.length / itemsPerPage).ceil();
      try {
        final newPageImages =
            await imagesRepo.search(query: state.query, page: page + 1);
        final hasNextPage = newPageImages.length >= itemsPerPage;
        yield state.copyWith(
          isLoadingNextPage: false,
          images: [...prevImages, ...newPageImages],
          hasNextPage: hasNextPage,
        );
      } catch (e) {
        print(e);
        yield state.copyWith(
          isLoadingNextPage: false,
          hasNextPage: false,
        );
      }
    }
  }
}

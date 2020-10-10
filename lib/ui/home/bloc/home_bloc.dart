import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:images_app/domain/index.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ImagesRepo imagesRepo;

  HomeBloc({
    this.imagesRepo,
  }) : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    final itemsPerPage = imagesRepo.itemsPerPage;
    if (event is HomeEventInitialLoad) {
      yield HomeState(query: event.query, isLoading: true);
      try{
        final images = await imagesRepo.search(query: event.query);
        final hasNextPage = images.length >= itemsPerPage;
        yield state.copyWith(
          images: images,
          isLoading: false,
          hasNextPage: hasNextPage,
        );
      }catch(e, s){
        print(e);
        yield state.copyWith(
          isLoading: false,
          errorMessage: e.toString()
        );
      }
    }

    if (event is HomeEventLoadNextPage) {
      yield state.copyWith(isLoadingNextPage: true);
      final prevImages = state.images;
      final page = (prevImages.length / itemsPerPage).ceil();
      try{
        final newPageImages =
        await imagesRepo.search(query: state.query, page: page+1);
        final hasNextPage = newPageImages.length >= itemsPerPage;
        yield state.copyWith(
          isLoadingNextPage: false,
          images: [...prevImages, ...newPageImages],
          hasNextPage: hasNextPage,
        );
      }catch(e,s){
        print(e);
        yield state.copyWith(
          isLoadingNextPage: false,
          loadNextPageErrorMessage: e.toString(),
          hasNextPage: false,
        );
      }

    }
  }
}

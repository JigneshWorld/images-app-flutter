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
    if (event is HomeEventInitialLoad) {
      yield HomeState(query: event.query, isLoading: true);
      final images = await imagesRepo.search(query: event.query);
      print(images);
      yield state.copyWith(images: images, isLoading: false);
    }
  }
}

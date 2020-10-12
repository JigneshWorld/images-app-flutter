part of 'images_bloc.dart';

abstract class ImagesEvent extends Equatable {
  const ImagesEvent();

  @override
  List<Object> get props => [];
}

class ImagesEventInitialLoad extends ImagesEvent {
  final String query;

  ImagesEventInitialLoad(this.query);

  @override
  List<Object> get props => [query];
}

class ImagesEventLoadNextPage extends ImagesEvent {}

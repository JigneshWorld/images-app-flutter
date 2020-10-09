part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeEventInitialLoad extends HomeEvent {
  final String query;

  HomeEventInitialLoad(this.query);

  @override
  List<Object> get props => [query];
}

class HomeEventLoadNextPage extends HomeEvent {

}
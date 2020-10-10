part of 'suggestions_bloc.dart';

abstract class SuggestionsEvent extends Equatable {
  const SuggestionsEvent();
}

class SuggestionsEventQueryChanged extends SuggestionsEvent {

  final String query;

  const SuggestionsEventQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
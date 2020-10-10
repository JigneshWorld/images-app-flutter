part of 'suggestions_bloc.dart';

class SuggestionsState extends Equatable {
  final String query;
  final List<String> suggestions;

  const SuggestionsState({
    this.query = '',
    this.suggestions = const [],
  });

  SuggestionsState copyWith(
    String query,
    List<String> suggestions,
  ) {
    return SuggestionsState(
      query: query,
      suggestions: suggestions,
    );
  }

  @override
  List<Object> get props => [query, suggestions];
}

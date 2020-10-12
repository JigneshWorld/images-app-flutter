/// suggestions repo interface
abstract class SuggestionsRepo {
  /// max number of suggestions to return to display on ui
  int get maxItemsToShow;

  /// return suggestions with filter based on query
  Future<List<String>> suggestions(String query);

  /// add query as a suggestion
  Future<bool> add(String query);
}

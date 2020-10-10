abstract class SuggestionsRepo {
  int get maxItemsToShow;
  Future<List<String>> suggestions(String query);
  Future<bool> add(String query);
}
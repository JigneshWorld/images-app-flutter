import 'package:flutter/cupertino.dart';
import 'package:images_app/domain/index.dart';

class SuggestionRepoImpl extends SuggestionsRepo {
  static const String KEY_RECENT_SEARCHED_TERMS = 'KEY_RECENT_SEARCHED_TERMS';

  final KeyValueStore store;
  final int maxSuggestionsToShow;

  SuggestionRepoImpl({
    @required this.store,
    @required this.maxSuggestionsToShow,
  });

  @override
  Future<bool> add(String query) async {
    var recentTerms = await store.getStringList(KEY_RECENT_SEARCHED_TERMS) ?? [];
    if (recentTerms.contains(query)) {
      recentTerms.remove(query);
    }
    recentTerms.insert(0, query);
    return store.setStringList(KEY_RECENT_SEARCHED_TERMS, recentTerms);
  }

  @override
  int get maxItemsToShow => maxSuggestionsToShow;

  @override
  Future<List<String>> suggestions(String query) async {
    final recent = await store.getStringList(KEY_RECENT_SEARCHED_TERMS) ?? [];
    final suggestions = (query == null || query.trim().isEmpty)
        ? recent
        : recent.where((element) => element.startsWith(query)).toList();
    return suggestions.take(maxItemsToShow).toList();
  }
}

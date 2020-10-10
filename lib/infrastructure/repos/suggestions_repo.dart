import 'package:flutter/cupertino.dart';
import 'package:images_app/domain/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionRepoImpl extends SuggestionsRepo {
  static const String KEY_RECENT_SEARCHED_TERMS = 'KEY_RECENT_SEARCHED_TERMS';

  final int maxSuggestionsToShow;

  SuggestionRepoImpl({@required this.maxSuggestionsToShow});

  @override
  Future<bool> add(String query) async {
    final prefs = await SharedPreferences.getInstance();
    var recentTerms = prefs.getStringList(KEY_RECENT_SEARCHED_TERMS) ?? [];
    if (recentTerms.contains(query)) {
      recentTerms.remove(query);
    }
    recentTerms.insert(0, query);
    return prefs.setStringList(KEY_RECENT_SEARCHED_TERMS, recentTerms);
  }

  @override
  int get maxItemsToShow => maxSuggestionsToShow;

  @override
  Future<List<String>> suggestions(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final recent = prefs.getStringList(KEY_RECENT_SEARCHED_TERMS) ?? [];
    final suggestions = (query == null || query.trim().isEmpty)
        ? recent
        : recent.where((element) => element.startsWith(query)).toList();
    return suggestions.take(maxItemsToShow).toList();
  }
}

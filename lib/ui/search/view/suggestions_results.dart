import 'package:flutter/material.dart';

import '../search.dart';

class SuggestionsResults extends StatelessWidget {
  final SuggestionsState state;

  final void Function(String suggestion) onTapSuggestion;

  const SuggestionsResults({
    Key key,
    this.state,
    this.onTapSuggestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stateQuery = state.query;
    return ListView.builder(
      itemBuilder: (_, index) {
        final suggestion = state.suggestions[index];
        return ListTile(
          leading: Icon(Icons.access_time),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, stateQuery.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                if (suggestion.length > stateQuery.length)
                  TextSpan(
                    text: suggestion.substring(stateQuery.length),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
              ],
            ),
          ),
          onTap: () {
            if (onTapSuggestion != null) {
              onTapSuggestion(suggestion);
            }
          },
        );
      },
      itemCount: state.suggestions.length,
    );
  }
}

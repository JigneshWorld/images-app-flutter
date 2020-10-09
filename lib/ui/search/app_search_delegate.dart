import 'package:flutter/material.dart';

import '../index.dart';

class AppSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          close(context, null);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) => null;

  @override
  Widget buildResults(BuildContext context) {
    return Home.buildResults(context, query);
  }

  final recentSearches = ['Yellow', 'Red', 'Magic'];

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSearches
        : recentSearches.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (_, index) {
        final suggestion = suggestionList[index];
        return ListTile(
          leading: Icon(Icons.refresh),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
      itemCount: suggestionList.length,
    );
  }
}

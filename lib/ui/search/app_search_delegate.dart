// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../index.dart';
import 'index.dart';
import 'search.dart' as search;

class AppSearchDelegate extends search.SearchDelegate<String> {
  final SuggestionsBloc bloc;

  AppSearchDelegate(this.bloc);

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

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.add(SuggestionsEventQueryChanged(query));
    return BlocBuilder<SuggestionsBloc, SuggestionsState>(
      cubit: bloc,
      builder: (_, state) {
        if (state.suggestions.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(48),
              child: Text('Press search button or enter on keyboard to search', textAlign: TextAlign.center,),
            ),
          );
        }

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
                    if(suggestion.length > stateQuery.length)
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
                query = suggestion;
                showResults(context);
              },
            );
          },
          itemCount: state.suggestions.length,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/search.dart' as search;
import '../search.dart';

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
    return ImagesResults(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.add(SuggestionsEventQueryChanged(query));
    return BlocBuilder<SuggestionsBloc, SuggestionsState>(
      cubit: bloc,
      builder: (_, state) {
        if (state.suggestions.isEmpty) {
          return SuggestionsNoResults();
        }

        return SuggestionsResults(
          state: state,
          onTapSuggestion: (suggestion) {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}

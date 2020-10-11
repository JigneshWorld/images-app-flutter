import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../search/search.dart';
import '../../widgets/search.dart' as search;

class SearchButton extends StatelessWidget {

  Future<void> _search(BuildContext context) async {
    // ignore: close_sinks
    final suggestionsBloc = BlocProvider.of<SuggestionsBloc>(context);
    suggestionsBloc.add(SuggestionsEventQueryChanged(''));
    await search.showSearch<String>(
      context: context,
      delegate: AppSearchDelegate(suggestionsBloc),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () => _search(context),
    );
  }
}

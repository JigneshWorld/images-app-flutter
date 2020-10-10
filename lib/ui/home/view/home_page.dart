import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../../search/index.dart';
import 'index.dart';
import '../../search/search.dart' as search;

class HomePage extends StatelessWidget {
  final bool onlyBody;

  const HomePage({
    Key key,
    this.onlyBody = false,
  }) : super(key: key);

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
    Widget body = BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.errorMessage != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        if (state.images.isNotEmpty) {
          return GridImagesView(
            bloc: BlocProvider.of<HomeBloc>(context),
            state: state,
          );
        }
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No Images Found',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 48,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CLOSE'),
              ),
            ],
          ),
        );
      },
    );
    if (onlyBody) {
      return body;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Images'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _search(context),
          )
        ],
      ),
      body: body,
    );
  }
}

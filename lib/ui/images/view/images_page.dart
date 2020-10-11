import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_app/domain/index.dart';
import '../../search/search.dart';
import 'package:provider/provider.dart';
import '../images.dart';

class ImagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<ImagesBloc>(
          create: (ctx) {
            return ImagesBloc(
              imagesRepo: RepositoryProvider.of<ImagesRepo>(ctx),
              suggestionsRepo: RepositoryProvider.of<SuggestionsRepo>(context),
            )..add(ImagesEventInitialLoad(''));
          },
        ),
        BlocProvider<SuggestionsBloc>(
          create: (ctx) {
            return SuggestionsBloc(
              suggestionsRepo: RepositoryProvider.of<SuggestionsRepo>(context),
            );
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Images'),
          centerTitle: true,
          actions: [
            SearchButton(),
          ],
        ),
        body: ImagesBodyBuilder(),
      ),
    );
  }
}

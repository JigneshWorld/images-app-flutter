import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_app/domain/index.dart';
import 'package:images_app/ui/images/images.dart';

class ImagesResults extends StatelessWidget {

  final String query;

  const ImagesResults({Key key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<ImagesBloc>(
            create: (ctx) {
              return ImagesBloc(
                suggestionsRepo: RepositoryProvider.of<SuggestionsRepo>(context),
                imagesRepo: RepositoryProvider.of<ImagesRepo>(ctx),
              )..add(ImagesEventInitialLoad(query));
            },
          )
        ],
        child: ImagesBodyBuilder(),
      );
  }
}

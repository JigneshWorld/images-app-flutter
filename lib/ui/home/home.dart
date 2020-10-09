import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_app/domain/index.dart';
import 'package:images_app/ui/home/bloc/home_bloc.dart';
import 'package:images_app/ui/home/view/index.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  static Widget buildResults(BuildContext context, String query){
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (ctx) {
            return HomeBloc(
              imagesRepo: RepositoryProvider.of<ImagesRepo>(ctx),
            )..add(HomeEventInitialLoad(query));
          },
        )
      ],
      child: HomePage(onlyBody: true,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (ctx) {
            return HomeBloc(
              imagesRepo: RepositoryProvider.of<ImagesRepo>(ctx),
            )..add(HomeEventInitialLoad(''));
          },
        )
      ],
      child: HomePage(),
    );
  }
}

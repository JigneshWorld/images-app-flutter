import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/index.dart';
import '../ui/index.dart';

class ImagesApp extends StatelessWidget {
  final ImagesRepo imagesRepo;
  final SuggestionsRepo suggestionsRepo;

  const ImagesApp({
    @required this.imagesRepo,
    @required this.suggestionsRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ImagesRepo>.value(value: imagesRepo),
        RepositoryProvider<SuggestionsRepo>.value(value: suggestionsRepo),
      ],
      child: MaterialApp(
        title: 'Images App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

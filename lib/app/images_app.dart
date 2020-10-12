import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/index.dart';
import '../ui/index.dart';

/// application widget
class ImagesApp extends StatelessWidget {
  final String title;
  final ImagesRepo imagesRepo;
  final SuggestionsRepo suggestionsRepo;

  const ImagesApp({
    @required this.title,
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
        title: title,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: ImagesPage(),
      ),
    );
  }
}

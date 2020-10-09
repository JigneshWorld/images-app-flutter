import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_app/domain/index.dart';
import 'package:images_app/ui/index.dart';

class ImagesApp extends StatelessWidget {
  final ImagesRepo imagesRepo;

  const ImagesApp({this.imagesRepo});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ImagesRepo>.value(value: imagesRepo),
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

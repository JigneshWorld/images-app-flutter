import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_app/ui/images/images.dart';
import 'index.dart';

class ImageSwiper extends StatelessWidget {
  final PageController controller;
  final ImagesBloc bloc;
  final int initialIndex;

  ImageSwiper({Key key, this.bloc, this.initialIndex})
      : controller = PageController(initialPage: initialIndex),
        super(key: key);

  static Route route(ImagesBloc bloc, int initialIndex) {
    return MaterialPageRoute(
      builder: (ctx) {
        return ImageSwiper(
          bloc: bloc,
          initialIndex: initialIndex,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<ImagesBloc, ImagesState>(
        cubit: bloc,
        builder: (_, state) {
          return ImagePager(
            bloc: bloc,
            state: state,
            initialIndex: initialIndex,
          );
        },
      ),
    );
  }
}


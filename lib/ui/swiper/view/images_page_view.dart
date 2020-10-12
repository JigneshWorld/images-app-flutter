import 'package:flutter/material.dart';
import 'package:images_app/ui/images/images.dart';

import 'index.dart';

class ImagePager extends StatelessWidget {
  final PageController controller;
  final ImagesBloc bloc;
  final int initialIndex;
  final ImagesState state;

  ImagePager({Key key, this.state, this.bloc, this.initialIndex})
      : controller = PageController(initialPage: initialIndex),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: (page) => onPageChanged(context, page),
      itemBuilder: (_, index) {
        if (index >= state.images.length) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final image = state.images[index];
        return InteractiveImageView(image: image);
      },
      itemCount: state.itemCount,
    );
  }

  void onPageChanged(BuildContext context, int page) {
    if (!bloc.state.isLoadingNextPage && page >= (bloc.state.itemCount - 5)) {
      bloc.add(ImagesEventLoadNextPage());
    }
  }
}

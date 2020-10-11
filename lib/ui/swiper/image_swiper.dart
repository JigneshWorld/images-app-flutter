import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_app/ui/home/bloc/home_bloc.dart';
import 'package:photo_view/photo_view.dart';

class ImageSwiper extends StatelessWidget {
  final PageController controller;
  final HomeBloc bloc;
  final int initialIndex;

  ImageSwiper({Key key, this.bloc, this.initialIndex})
      : controller = PageController(initialPage: initialIndex),
        super(key: key);

  static Route route(HomeBloc bloc, int initialIndex) {
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
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (_, state) {
          if (state.itemCount > 0) {
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
                return Container(
                  child: Center(
                    child: PhotoView(
                      backgroundDecoration: BoxDecoration(color: Colors.white),
                      imageProvider:
                          CachedNetworkImageProvider(image.largeURL),
                      loadingBuilder: (_, __) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.itemCount,
            );
          }
          return Center(
            child: Text('Unknown'),
          );
        },
        cubit: bloc,
      ),
    );
  }

  void onPageChanged(BuildContext context, int page) {
    if (!bloc.state.isLoadingNextPage && page >= (bloc.state.itemCount - 5)) {
      bloc.add(HomeEventLoadNextPage());
    }
  }
}

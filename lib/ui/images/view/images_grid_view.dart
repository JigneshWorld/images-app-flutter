import 'package:flutter/material.dart';
import 'package:images_app/main.dart';
import 'package:images_app/ui/swiper/swiper.dart';
import '../images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImagesGridView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final ImagesState state;
  final ImagesBloc bloc;

  ImagesGridView({Key key, this.state, this.bloc}) : super(key: key);

  void onTapImage(BuildContext context, int initialIndex) {
    Navigator.push(context, ImageSwiper.route(bloc, initialIndex));
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: StaggeredGridView.countBuilder(
          primary: false,
          crossAxisCount: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          staggeredTileBuilder: (index) => kAppGridTileStaggered
              ? StaggeredTile.fit(2)
              : StaggeredTile.count(2, 2),
          itemBuilder: (_, index) {
            if ((index >= state.images.length)) {
              return _loaderGridItem();
            }
            final image = state.images[index];
            return InkWell(
              onTap: () => onTapImage(context, index),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: image.thumbURL,
                placeholder: (context, url) => Container(
                  color: Colors.grey[500],
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[500],
                ),
              ),
            );
          },
          itemCount: state.itemCount,
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _loaderGridItem() {
    return Container(child: Center(child: CircularProgressIndicator()));
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter < 500) {
      bloc.add(ImagesEventLoadNextPage());
    }
    return false;
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:images_app/domain/index.dart';
import 'package:photo_view/photo_view.dart';

class InteractiveImageView extends StatelessWidget {
  const InteractiveImageView({
    Key key,
    @required this.image,
  }) : super(key: key);

  final AppImage image;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      backgroundDecoration: BoxDecoration(color: Colors.white),
      imageProvider: CachedNetworkImageProvider(image.largeURL),
      loadingBuilder: (_, __) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
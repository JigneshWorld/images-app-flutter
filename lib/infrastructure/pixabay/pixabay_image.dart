import 'package:equatable/equatable.dart';
import 'package:images_app/domain/index.dart';

/// pixabay app image model implementation
class PixabayImage extends Equatable implements AppImage {
  final int pid;
  final String pageURL;
  final String type;
  final String tags;
  final String previewURL;
  final int previewWidth;
  final int previewHeight;
  final String webformatURL;
  final int webformatWidth;
  final int webformatHeight;
  final String largeImageURL;
  final int imageWidth;
  final int imageHeight;
  final int imageSize;
  final int views;
  final int downloads;
  final int favorites;
  final int likes;
  final int comments;
  final int userId;
  final String user;
  final String userImageURL;

  PixabayImage({
    this.pid,
    this.pageURL,
    this.type,
    this.tags,
    this.previewURL,
    this.previewWidth,
    this.previewHeight,
    this.webformatURL,
    this.webformatWidth,
    this.webformatHeight,
    this.largeImageURL,
    this.imageWidth,
    this.imageHeight,
    this.imageSize,
    this.views,
    this.downloads,
    this.favorites,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageURL,
  });

  @override
  String get thumbURL => webformatURL;

  @override
  String get largeURL => largeImageURL;

  @override
  List<Object> get props => [pid, previewURL, webformatURL, largeURL];
}

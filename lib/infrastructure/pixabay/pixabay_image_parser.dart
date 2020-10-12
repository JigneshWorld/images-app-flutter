import 'pixabay_image.dart';

/// pixabay images parser implementation
class PixabayImageParser {
  const PixabayImageParser();

  PixabayImage fromJson(Map<String, dynamic> json) {
    return PixabayImage(
      pid: json['id'],
      pageURL: json['pageURL'],
      type: json['type'],
      tags: json['tags'],
      previewURL: json['previewURL'],
      previewWidth: json['previewWidth'],
      previewHeight: json['previewHeight'],
      webformatURL: json['webformatURL'],
      webformatWidth: json['webformatWidth'],
      webformatHeight: json['webformatHeight'],
      largeImageURL: json['largeImageURL'],
      imageWidth: json['imageWidth'],
      imageHeight: json['imageHeight'],
      imageSize: json['imageSize'],
      views: json['views'],
      downloads: json['downloads'],
      favorites: json['favorites'],
      likes: json['likes'],
      comments: json['comments'],
      userId: json['userid'],
      user: json['user'],
      userImageURL: json['userImageURL'],
    );
  }
}

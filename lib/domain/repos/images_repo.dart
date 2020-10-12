import 'package:images_app/domain/models/app_image.dart';

/// images repo interface
abstract class ImagesRepo {
  /// number of images to load per page
  int get itemsPerPage;

  /// search images with pagination
  Future<List<AppImage>> search({String query, int page = 1});
}

import 'package:images_app/domain/models/app_image.dart';

abstract class ImagesRepo {
  Future<List<AppImage>> search({String query, int page = 1});
}

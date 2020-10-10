import 'package:images_app/domain/models/app_image.dart';

abstract class ImagesRepo {
  int get itemsPerPage;
  Future<List<AppImage>> search({String query, int page = 1});
}

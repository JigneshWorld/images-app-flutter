import 'dart:io';

import 'package:dio/dio.dart';
import 'package:images_app/domain/index.dart';

class ImagesRepoImpl extends ImagesRepo {
  final Dio _dio;

  ImagesRepoImpl()
      : _dio = Dio(
          BaseOptions(baseUrl: 'https://pixabay.com/'),
        );

  @override
  Future<List<AppImage>> search({String query, int page = 1}) async {
    final params = <String, dynamic>{
      'key': '18643016-c9f6d73eae18eb564a915a024',
      'page': page,
      'image_type': 'photo'
    };
    if (query != null && query.trim().isNotEmpty) {
      params['q'] = Uri.encodeQueryComponent(query.trim());
    }
    print(params);
    try {
      final response = await _dio.get('api', queryParameters: params);
      if (response.statusCode == HttpStatus.ok) {
        print(response.data);
        final body = Map<String, dynamic>.from(response.data);
        final total = body['total'];
        final totalHits = body['totalHits'];
        final hits = body['hits'] as List<dynamic>;
        return hits.map((hit) => AppImage.fromJson(hit)).toList();
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        print(response.data);
        throw HttpException(response.statusMessage);
      }
    } catch (e, s) {
      print(e);
      if(e is DioError){
        print(e.response);
        print(e.message);
        print(e.error);
        print(e.type);
        throw HttpException(e.response.toString());
      }else{
        throw HttpException(e.toString());
      }
    }
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:images_app/domain/index.dart';
import 'index.dart';

class PixabayImagesRepo extends ImagesRepo {
  final Dio _dio;
  final String baseUrl;
  final String apiKey;
  final int imagesPerPage;
  final PixabayImageParser parser;

  PixabayImagesRepo({
    @required this.baseUrl,
    @required this.apiKey,
    @required this.imagesPerPage,
    this.parser = const PixabayImageParser(),
  }) : _dio = Dio(
          BaseOptions(baseUrl: baseUrl),
        );

  @override
  Future<List<AppImage>> search({
    String query,
    int page = 1,
  }) async {
    final params = <String, dynamic>{
      'key': apiKey,
      'page': page,
      'per_page': itemsPerPage,
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
        final hits = body['hits'] as List<dynamic>;
        return hits
            .map((hit) => parser.fromJson(hit))
            .toList();
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        print(response.data);
        throw HttpException(response.statusMessage);
      }
    } catch (e) {
      print(e);
      if (e is DioError) {
        print(e.response);
        print(e.message);
        print(e.error);
        print(e.type);
        throw HttpException(e.response.toString());
      } else {
        throw HttpException(e.toString());
      }
    }
  }

  @override
  int get itemsPerPage => imagesPerPage;
}

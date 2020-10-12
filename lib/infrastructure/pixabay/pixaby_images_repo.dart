import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:images_app/domain/index.dart';

import 'index.dart';

/// pixabay images repo implementation
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
    try {
      final response = await _dio.get('api', queryParameters: params);
      if (response.statusCode == HttpStatus.ok) {
        final body = Map<String, dynamic>.from(response.data);
        final hits = body['hits'] as List<dynamic>;
        return hits.map((hit) => parser.fromJson(hit)).toList();
      } else {
        throw HttpException(response.statusMessage);
      }
    } catch (e, s) {
      Fimber.e('error: api: failed to fetch images', ex: e, stacktrace: s);
      if (e is DioError) {
        throw HttpException(e.response.toString());
      } else {
        throw HttpException(e.toString());
      }
    }
  }

  @override
  int get itemsPerPage => imagesPerPage;
}

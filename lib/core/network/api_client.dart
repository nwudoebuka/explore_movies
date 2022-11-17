
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:explore/core/utils/export.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  ApiClient() {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 1000 * 60,
      receiveTimeout: 1000 * 60,
      contentType: 'application/json',
      validateStatus: _validateStatus,
    );

    _dio ??= Dio(options);

    final presetHeaders = <String, String>{
      Headers.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
      // if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    _dio!.options.headers = presetHeaders;

    if (kDebugMode) {
      _dio!.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          requestBody: true,
          responseBody: true,
          error: false,
        ),
      );
    }
  }

  //final AuthLocalSource authLocalSource;

  Dio? _dio;

  static String baseUrl = AppConfig.baseUrl;


  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio!.get(
        uri,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }

  Future<Response> post(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extraHeaders,
  }) async {
    try {
      final dio = _dio!;
      if (extraHeaders != null) {
        dio.options.headers.addAll(extraHeaders);
      }
      final response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }

  Future<Response> put(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio!.put(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }

  Future<Response> patch(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio!.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }

  Future<Response> delete(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio!.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }

  Future<Response> uploadFiles(
    String uri, {
    required List<File> files,
  }) async {
    try {

      final formData = FormData.fromMap(
        {
          'files': [
            for (var file in files)
              await MultipartFile.fromFile(
                file.path,
              ),
          ]
        },
      );

      final response = await _dio!.post(
        uri,
        data: formData,
      );

      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }


  // validate the status of a request
  bool _validateStatus(int? status) {
    return status! == 200 || status == 201;
  }
}

extension ResponseExtension on Response {
  bool get isSuccess {
    final is200 = statusCode == HttpStatus.ok;
    final is201 = statusCode == HttpStatus.created;
    return is200 || is201;
  }
}
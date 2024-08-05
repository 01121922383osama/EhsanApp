import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'api_consumer.dart';
import 'api_enterseptor.dart';
import 'end_point.dart';
import 'status_code.dart';
import '../error/exceptions.dart';
import '../../injection_container.dart' as di;

class DioConsumer implements ApiConsumerService {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      ..baseUrl = EndPoint.baseURL
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.sl<AppIntercepters>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    if (response.data != null &&
        response.data is String &&
        response.data.trim().isNotEmpty) {
      try {
        final responseJson = jsonDecode(response.data);
        final surahs = responseJson['data']['timings'];
        return surahs;
      } catch (e) {
        return response.data;
      }
    } else {
      return response.data;
    }
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.confilct:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw const NoInterNetConnectionException();
      case DioExceptionType.unknown:
        throw const NoInterNetConnectionException();
    }
    return null;
  }

  @override
  Future<dynamic> get({String? url}) async {
    try {
      final response = await client.get(url!);
      if (response.statusCode == 302) {
        final redirectUrl = response.headers['location']!.first;
        return get(url: redirectUrl);
      } else {
        return _handleResponseAsJson(response);
      }
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }
}

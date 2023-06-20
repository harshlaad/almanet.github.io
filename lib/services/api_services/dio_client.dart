import 'dart:developer';

import 'package:app/services/api_services/dio_exception.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio();
  DioClient() {
    _dio.interceptors.add(AppInterceptors(_dio));
  }

  static Future<Map<String, dynamic>> getMethod({required String url}) async {
    Map<String, dynamic>? authorisation = Db.auth.getAuthorisation();
    try {
      Response response;
      if (authorisation != null) {
        response = await _dio.get(
          url,
          options: Options(
            headers: {
              "Authorization": "Bearer " + authorisation['accessToken']
            },
          ),
        );
      } else {
        response = await _dio.get(url);
      }
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return {
        "status": false,
        "message": errorMessage,
        "actual_error": e.response,
      };
    }
  }

  static Future<Map<String, dynamic>> postMethod(
      {required String url, Map<String, dynamic>? body}) async {
    Map<String, dynamic>? authorisation = Db.auth.getAuthorisation();
    try {
      Response response;
      if (authorisation != null) {
        response = await _dio.post(
          url,
          data: body,
          options: Options(
            headers: {
              "Authorization": "Bearer " + authorisation['accessToken']
            },
          ),
        );
      } else {
        response = await _dio.post(
          url,
          data: body,
        );
      }

      return response.data;
    } on DioError catch (e) {
      log(e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return {
        "status": false,
        "message": errorMessage,
        "actual_message": e.response,
      };
    }
  }

  static Future<Map<String, dynamic>> postMethodWithFormData(
      {required String url, Map<String, dynamic>? body}) async {
    Map<String, dynamic>? authorisation = Db.auth.getAuthorisation();
    try {
      Response response;
      if (authorisation != null) {
        response = await _dio.post(
          url,
          data: body == null ? body : FormData.fromMap(body),
          // options: Options(
          //   headers: {
          //     "Authorization": "Bearer " + authorisation['accessToken']
          //   },
          // ),
        );
      } else {
        response = await _dio.post(
          url,
          data: body == null ? body : FormData.fromMap(body),
        );
      }
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();

      return {
        "status": false,
        "message": errorMessage,
        "actual_message": e.response,
      };
    }
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

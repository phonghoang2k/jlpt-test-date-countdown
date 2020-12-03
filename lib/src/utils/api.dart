import 'dart:async';

import 'package:dio/dio.dart';

class API {
  static String baseUrl = "https://becountdown.herokuapp.com";
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: 30000,
      sendTimeout: 60000,
      receiveTimeout: 30000,
      contentType: 'application/json; charset=utf-8',
      baseUrl: baseUrl,
    ),
  );

  API() {
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
//    dio.interceptors
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print(options.uri);
      // print(options.data);
      // print(options.headers['Abp.userId']);
      // Do something before request is sent
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error

      return e.response; //continue
    }));
  }

  Future get(String url, [Map<String, dynamic> params]) async {
    return dio.get(url, queryParameters: params);
  }

  Future post(String url, Map<String, dynamic> params) async {
    return dio.post(url, data: params);
  }

  Future put(String url, [Map<String, dynamic> params]) async {
    return dio.put(url, data: params);
  }

  Future delete(String url, [Map<String, dynamic> params]) async {
    return dio.delete(url, queryParameters: params);
  }
}

import 'dart:io';

import 'package:dio/dio.dart';

var dio = Dio(BaseOptions(
  baseUrl: 'http://movie.ihaoze.cn/',
  connectTimeout: 5000,
  receiveTimeout: 100000,

  headers: {
    HttpHeaders.userAgentHeader: 'dio',
    'api': '1.0.0'
  },
  contentType: Headers.jsonContentType,
  responseType: ResponseType.json
));
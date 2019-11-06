import 'package:dio/dio.dart';
import 'package:flutter_learn/module/movie/model/movie_model.dart';

///豆瓣电影api
class MovieApi {
  static Dio _dio;
  static const String API_TOP = "v2/movie/top250";
  static const String API_IN_THEATERS = "v2/movie/in_theaters";
  static const String API_COMING_SOON = "v2/movie/coming_soon";

  ///获取电影数据列表
  static Future getMovie(String url, int star, int count) async {
    if (_dio == null) {
      _dio = Dio();
      _dio.options.baseUrl = "https://api.douban.com/";
      _dio.options.connectTimeout = 5000;
      _dio.options.receiveTimeout = 5000;
      _dio.options.responseType = ResponseType.json;
      _dio.options.contentType =Headers.jsonContentType;
      _dio.options.headers = {'user-agent': 'dio', 'from': "dio"};

      ///添加日志拦截器
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
    Response response = await _dio.get<Map>(url, queryParameters: {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "start": star,
      "count": count,
    });
    MovieModel model = MovieModel.fromJson(response.data);
    return model.subjects;
  }
}

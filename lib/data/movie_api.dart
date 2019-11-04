import 'package:dio/dio.dart';
import 'package:flutter_learn/module/movie/model/movie_model.dart';

///豆瓣电影api
class MovieAPi {
  ///获取电影数据列表
  static Future getMovie(String url, int star, int count) async {
    Dio dio = Dio();
    dio.options.baseUrl = "https://api.douban.com/";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.responseType = ResponseType.json;
    dio.options.headers = {'user-agent': 'dio', 'from': "dio"};

    ///添加日志拦截器
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    Response response = await dio.get<Map>(url, queryParameters: {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "start": star,
      "count": count,
    });
    MovieModel model = MovieModel.fromJson(response.data);
    return model.subjects;
  }
}

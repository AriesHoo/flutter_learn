import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_learn/model/movie_model.dart';

class MovieAPi {


  static Future getMovie(String url) async {
    Dio dio = Dio();
    dio.options.baseUrl = "https://api.douban.com/";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.responseType = ResponseType.json;
    dio.options.headers = {'user-agent': 'dio', 'from': "dio"};
    Response response = await dio.get<Map>(url, queryParameters: {
      "apikey": "0b2bdeda43b5688921839c8ecb20399b",
      "start": 0,
      "count": 10,
    });
    debugPrint(response.data.toString());
    var model = MovieModel.fromJson(response.data);
    debugPrint("MovieModel"+model.toJson().toString());
    return model;
  }
}

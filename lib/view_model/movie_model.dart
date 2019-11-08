import 'package:flutter_learn/data/movie_api.dart';
import 'package:flutter_learn/module/movie/model/movie_model.dart';
import 'package:flutter_learn/view_model/view_state_list_model.dart';
import 'package:flutter_learn/view_model/view_state_refresh_list_model.dart';

///模拟获取电影tab
class MovieTabModel extends ViewStateListModel<String> {
  final List<String> listTab;
  final List<String> listUrl;

  MovieTabModel(this.listTab, this.listUrl);

  @override
  Future<List<String>> loadData() {
    return  Future.delayed(Duration(milliseconds: 2000), () {
      return listUrl;
    });
  }
}

///获取电影列表数据
class MovieListModel extends ViewStateRefreshListModel<Subjects> {
  final String url;

  MovieListModel(this.url);

  @override
  Future<List<Subjects>> loadData({int pageNum}) async {
    return await MovieApi.getMovie(url, pageNum * pageSize, pageSize);
  }
}

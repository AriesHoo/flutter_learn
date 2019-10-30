class MovieModel {
  int _count;
  int _start;
  int _total;
  List<Subjects> _subjects;
  String _title;

  MovieModel(
      {int count,
        int start,
        int total,
        List<Subjects> subjects,
        String title}) {
    this._count = count;
    this._start = start;
    this._total = total;
    this._subjects = subjects;
    this._title = title;
  }

  int get count => _count;
  set count(int count) => _count = count;
  int get start => _start;
  set start(int start) => _start = start;
  int get total => _total;
  set total(int total) => _total = total;
  List<Subjects> get subjects => _subjects;
  set subjects(List<Subjects> subjects) => _subjects = subjects;
  String get title => _title;
  set title(String title) => _title = title;

  MovieModel.fromJson(Map<String, dynamic> json) {
    _count = json['count'];
    _start = json['start'];
    _total = json['total'];
    if (json['subjects'] != null) {
      _subjects = new List<Subjects>();
      json['subjects'].forEach((v) {
        _subjects.add(new Subjects.fromJson(v));
      });
    }
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this._count;
    data['start'] = this._start;
    data['total'] = this._total;
    if (this._subjects != null) {
      data['subjects'] = this._subjects.map((v) => v.toJson()).toList();
    }
    data['title'] = this._title;
    return data;
  }
}

class Subjects {
  Rating _rating;
  List<String> _genres;
  String _title;
  List<String> _durations;
  int _collectCount;
  String _mainlandPubdate;
  bool _hasVideo;
  String _originalTitle;
  String _subtype;
  String _year;
  Images _images;
  String _alt;
  String _id;

  Subjects(
      {Rating rating,
        List<String> genres,
        String title,
        List<String> durations,
        int collectCount,
        String mainlandPubdate,
        bool hasVideo,
        String originalTitle,
        String subtype,
        String year,
        Images images,
        String alt,
        String id}) {
    this._rating = rating;
    this._genres = genres;
    this._title = title;
    this._durations = durations;
    this._collectCount = collectCount;
    this._mainlandPubdate = mainlandPubdate;
    this._hasVideo = hasVideo;
    this._originalTitle = originalTitle;
    this._subtype = subtype;
    this._year = year;
    this._images = images;
    this._alt = alt;
    this._id = id;
  }

  Rating get rating => _rating;
  set rating(Rating rating) => _rating = rating;
  List<String> get genres => _genres;
  set genres(List<String> genres) => _genres = genres;
  String get title => _title;
  set title(String title) => _title = title;
  List<String> get durations => _durations;
  set durations(List<String> durations) => _durations = durations;
  int get collectCount => _collectCount;
  set collectCount(int collectCount) => _collectCount = collectCount;
  String get mainlandPubdate => _mainlandPubdate;
  set mainlandPubdate(String mainlandPubdate) =>
      _mainlandPubdate = mainlandPubdate;
  bool get hasVideo => _hasVideo;
  set hasVideo(bool hasVideo) => _hasVideo = hasVideo;
  String get originalTitle => _originalTitle;
  set originalTitle(String originalTitle) => _originalTitle = originalTitle;
  String get subtype => _subtype;
  set subtype(String subtype) => _subtype = subtype;
  String get year => _year;
  set year(String year) => _year = year;
  Images get images => _images;
  set images(Images images) => _images = images;
  String get alt => _alt;
  set alt(String alt) => _alt = alt;
  String get id => _id;
  set id(String id) => _id = id;

  Subjects.fromJson(Map<String, dynamic> json) {
    _rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    _genres = json['genres'].cast<String>();
    _title = json['title'];
    _durations = json['durations'].cast<String>();
    _collectCount = json['collect_count'];
    _mainlandPubdate = json['mainland_pubdate'];
    _hasVideo = json['has_video'];
    _originalTitle = json['original_title'];
    _subtype = json['subtype'];
    _year = json['year'];
    _images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    _alt = json['alt'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._rating != null) {
      data['rating'] = this._rating.toJson();
    }
    data['genres'] = this._genres;
    data['title'] = this._title;
    data['durations'] = this._durations;
    data['collect_count'] = this._collectCount;
    data['mainland_pubdate'] = this._mainlandPubdate;
    data['has_video'] = this._hasVideo;
    data['original_title'] = this._originalTitle;
    data['subtype'] = this._subtype;
    data['year'] = this._year;
    if (this._images != null) {
      data['images'] = this._images.toJson();
    }
    data['alt'] = this._alt;
    data['id'] = this._id;
    return data;
  }
}

class Rating {
  int _max;
  double _average;
  String _stars;
  int _min;

  Rating({int max, double average, String stars, int min}) {
    this._max = max;
    this._average = average;
    this._stars = stars;
    this._min = min;
  }

  int get max => _max;
  set max(int max) => _max = max;
  double get average => _average;
  set average(double average) => _average = average;
  String get stars => _stars;
  set stars(String stars) => _stars = stars;
  int get min => _min;
  set min(int min) => _min = min;

  Rating.fromJson(Map<String, dynamic> json) {
    _max = json['max'];
    _average = json['average'];
    _stars = json['stars'];
    _min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this._max;
    data['average'] = this._average;
    data['stars'] = this._stars;
    data['min'] = this._min;
    return data;
  }
}

class Images {
  String _small;
  String _large;
  String _medium;

  Images({String small, String large, String medium}) {
    this._small = small;
    this._large = large;
    this._medium = medium;
  }

  String get small => _small;
  set small(String small) => _small = small;
  String get large => _large;
  set large(String large) => _large = large;
  String get medium => _medium;
  set medium(String medium) => _medium = medium;

  Images.fromJson(Map<String, dynamic> json) {
    _small = json['small'];
    _large = json['large'];
    _medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this._small;
    data['large'] = this._large;
    data['medium'] = this._medium;
    return data;
  }
}




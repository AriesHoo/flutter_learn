// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return MovieModel(
    json['count'] as int,
    json['start'] as int,
    json['total'] as int,
    (json['subjects'] as List)
        ?.map((e) =>
            e == null ? null : Subjects.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['title'] as String,
  );
}

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'start': instance.start,
      'total': instance.total,
      'subjects': instance.subjects,
      'title': instance.title,
    };

Subjects _$SubjectsFromJson(Map<String, dynamic> json) {
  return Subjects(
    json['rating'] == null
        ? null
        : Rating.fromJson(json['rating'] as Map<String, dynamic>),
    (json['genres'] as List)?.map((e) => e as String)?.toList(),
    json['title'] as String,
    (json['casts'] as List)
        ?.map(
            (e) => e == null ? null : Casts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['durations'] as List)?.map((e) => e as String)?.toList(),
    json['collect_count'] as int,
    json['mainland_pubdate'] as String,
    json['has_video'] as bool,
    json['original_title'] as String,
    json['subtype'] as String,
    (json['directors'] as List)
        ?.map((e) =>
            e == null ? null : Directors.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['pubdates'] as List)?.map((e) => e as String)?.toList(),
    json['year'] as String,
    json['images'] == null
        ? null
        : Images.fromJson(json['images'] as Map<String, dynamic>),
    json['alt'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$SubjectsToJson(Subjects instance) => <String, dynamic>{
      'rating': instance.rating,
      'genres': instance.genres,
      'title': instance.title,
      'casts': instance.casts,
      'durations': instance.durations,
      'collect_count': instance.collectCount,
      'mainland_pubdate': instance.mainlandPubdate,
      'has_video': instance.hasVideo,
      'original_title': instance.originalTitle,
      'subtype': instance.subtype,
      'directors': instance.directors,
      'pubdates': instance.pubdates,
      'year': instance.year,
      'images': instance.images,
      'alt': instance.alt,
      'id': instance.id,
    };

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating(
    json['max'] as int,
    (json['average'] as num)?.toDouble(),
    json['stars'] as String,
    json['min'] as int,
  );
}

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'max': instance.max,
      'average': instance.average,
      'stars': instance.stars,
      'min': instance.min,
    };

Casts _$CastsFromJson(Map<String, dynamic> json) {
  return Casts(
    json['avatars'] == null
        ? null
        : Avatars.fromJson(json['avatars'] as Map<String, dynamic>),
    json['name_en'] as String,
    json['name'] as String,
    json['alt'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$CastsToJson(Casts instance) => <String, dynamic>{
      'avatars': instance.avatars,
      'name_en': instance.nameEn,
      'name': instance.name,
      'alt': instance.alt,
      'id': instance.id,
    };

Avatars _$AvatarsFromJson(Map<String, dynamic> json) {
  return Avatars(
    json['small'] as String,
    json['large'] as String,
    json['medium'] as String,
  );
}

Map<String, dynamic> _$AvatarsToJson(Avatars instance) => <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
      'medium': instance.medium,
    };

Directors _$DirectorsFromJson(Map<String, dynamic> json) {
  return Directors(
    json['avatars'] == null
        ? null
        : Avatars.fromJson(json['avatars'] as Map<String, dynamic>),
    json['name_en'] as String,
    json['name'] as String,
    json['alt'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$DirectorsToJson(Directors instance) => <String, dynamic>{
      'avatars': instance.avatars,
      'name_en': instance.nameEn,
      'name': instance.name,
      'alt': instance.alt,
      'id': instance.id,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return Images(
    json['small'] as String,
    json['large'] as String,
    json['medium'] as String,
  );
}

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
      'medium': instance.medium,
    };

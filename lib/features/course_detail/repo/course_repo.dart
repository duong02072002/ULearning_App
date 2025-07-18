import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/models/lesson_entities.dart';
import 'package:flutter_ulearning_app/common/models/review_entities.dart';
import 'package:flutter_ulearning_app/common/services/http_until.dart';

class CourseRepo {
  static Future<CourseDetailResponseEntity> courseDetail({
    CourseRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      "api/courseDetail",
      queryParameters: params?.toJson(),
    );
    return CourseDetailResponseEntity.fromJson(response);
  }

  static Future<LessonListResponseEntity> courseLessonList({
    LessonRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      "api/lessonList",
      queryParameters: params?.toJson(),
    );
    return LessonListResponseEntity.fromJson(response);
  }
}

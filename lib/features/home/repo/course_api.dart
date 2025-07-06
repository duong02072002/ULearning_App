import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/services/http_until.dart';

class CourseRepo {
  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post('api/courseList');
    return CourseListResponseEntity.fromJson(response);
  }
}

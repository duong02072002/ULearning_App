import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/services/http_until.dart';

class CoursesBoughtRepo {
  static Future<CourseListResponseEntity> coursesBought() async {
    var response = await HttpUtil().post("api/coursesBought");
    return CourseListResponseEntity.fromJson(response);
  }

  static Future<CourseListResponseEntity> coursesBoughtSearch({
    SearchRequestEntity? params,
  }) async {
    // Gửi đúng vào JSON body
    var response = await HttpUtil().post(
      "api/coursesBoughtSearch",
      data: params?.toJson(), // ✅ ĐÚNG
    );
    return CourseListResponseEntity.fromJson(response);
  }
}

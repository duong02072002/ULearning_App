import 'package:flutter_ulearning_app/common/models/base_entities.dart';
import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/services/http_until.dart';

class BuyCourseRepo {
  static Future<BaseResponseEntity> buyCourse({
    CourseRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      "api/checkout",
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }
}

import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/models/course_type_entity.dart';
import 'package:flutter_ulearning_app/common/models/search_filter.dart';
import 'package:flutter_ulearning_app/common/services/http_until.dart';

class CoursesSearchRepos {
  static Future<CourseListResponseEntity> coursesDefaultSearch() async {
    var response = await HttpUtil().post("api/coursesSearchDefault");
    return CourseListResponseEntity.fromJson(response);
  }

  static Future<CourseSearchResponse> searchCourses(SearchFilter f) async {
    final resp = await HttpUtil().get(
      'api/coursesSearch',
      queryParameters: f.toJson(),
    );
    return CourseSearchResponse.fromJson(resp);
  }

  /// GET /api/course_types
  Future<List<CourseTypeEntity>> getAll() async {
    final resp = await HttpUtil().get('api/courseTypes');
    // resp có dạng { code, msg, data: [ {id, title}, ... ] }
    final List data = resp['data'] as List? ?? [];
    return data
        .map((e) => CourseTypeEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

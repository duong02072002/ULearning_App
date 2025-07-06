import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/features/author_page/repo/course_author_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'author_controller.g.dart';

@riverpod
class AuthorCourseListController extends _$AuthorCourseListController {
  @override
  FutureOr<List<CourseItem>?> build() async {
    return [];
  }

  void init(String token) {
    loadCourseData(token);
  }

  loadCourseData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var response = await CourseAuthorRepo.authorCourseList(
      params: authorRequestEntity,
    );
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
    }
  }
}

@riverpod
class CourseAuthorController extends _$CourseAuthorController {
  @override
  FutureOr<AuthorItem?> build() async {
    return null;
  }

  void init(String token) {
    loadAuthor(token);
  }

  loadAuthor(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var response = await CourseAuthorRepo.courseAuthor(
      params: authorRequestEntity,
    );
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
    }
  }
}

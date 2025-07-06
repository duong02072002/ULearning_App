import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/features/search/repo/courses_search_repos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class CoursesSearchController extends AsyncNotifier<List<CourseItem>?> {
  @override
  FutureOr<List<CourseItem>?> build() async {
    final response = await CoursesSearchRepos.coursesDefaultSearch();
    if (response.code == 200) {
      return response.data;
    }
    // TODO: implement build
    return [];
  }

  reloadSearchData() async {
    final response = await CoursesSearchRepos.coursesDefaultSearch();
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
      return;
    }
    // TODO: implement build
    state = const AsyncValue.data([]);
  }

  searchData(String search) async {
    SearchRequestEntity searchRequestEntity = SearchRequestEntity();
    searchRequestEntity.search = search;
    var response = await CoursesSearchRepos.coursesSearch(
      params: searchRequestEntity,
    );
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
    } else {
      state = AsyncValue.data([]);
    }
  }
}

final coursesSearchControllerProvider =
    AsyncNotifierProvider<CoursesSearchController, List<CourseItem>?>(
      CoursesSearchController.new,
    );

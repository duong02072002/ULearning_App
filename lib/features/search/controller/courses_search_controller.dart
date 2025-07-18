import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/models/course_type_entity.dart';
import 'package:flutter_ulearning_app/common/models/search_filter.dart';
import 'package:flutter_ulearning_app/features/search/repo/courses_search_repos.dart';

class CoursesSearchController extends AsyncNotifier<CourseSearchResponse?> {
  late SearchFilter _filter;

  @override
  FutureOr<CourseSearchResponse?> build() {
    _filter = SearchFilter(); // mặc định
    return _load();
  }

  Future<CourseSearchResponse> _load() {
    return CoursesSearchRepos.searchCourses(_filter);
  }

  /// Bật lại filter hoàn toàn mới
  Future<void> applyFilter(SearchFilter f) async {
    _filter = f;
    state = const AsyncLoading();
    state = AsyncData(await _load());
  }

  /// Chuyển trang
  Future<void> loadPage(int page) async {
    _filter = SearchFilter(
      search: _filter.search,
      categories: _filter.categories,
      minPrice: _filter.minPrice,
      maxPrice: _filter.maxPrice,
      minScore: _filter.minScore,
      maxScore: _filter.maxScore,
      minLessons: _filter.minLessons,
      maxLessons: _filter.maxLessons,
      perPage: _filter.perPage,
      page: page,
    );
    state = const AsyncLoading();
    state = AsyncData(await _load());
  }

  Future<void> reset() async {
    _filter = SearchFilter(); // mặc định
    state = const AsyncLoading();
    state = AsyncData(await _load());
  }
}

final coursesSearchControllerProvider =
    AsyncNotifierProvider<CoursesSearchController, CourseSearchResponse?>(
      CoursesSearchController.new,
    );

/// FutureProvider trả về list CourseTypeEntity
final categoriesProvider = FutureProvider<List<CourseTypeEntity>>((ref) async {
  final repo = CoursesSearchRepos();
  return repo.getAll();
});

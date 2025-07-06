import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/features/courses_bought/repo/courses_bought_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'courses_bought_controller.g.dart';

@riverpod
class CoursesBoughtController extends _$CoursesBoughtController {
  @override
  FutureOr<List<CourseItem>?> build() async {
    final response = await CoursesBoughtRepo.coursesBought();
    if (response.code == 200) {
      return response.data;
    } else {
      if (kDebugMode) {
        print("Request failed with status code ${response.code}");
      }
    }
    //state.asError;
    return null;
  }

  Future<void> searchCourses(String search) async {
    SearchRequestEntity request = SearchRequestEntity();
    request.search = search;

    print(">> Sending search request: ${request.toJson()}");

    try {
      final response = await CoursesBoughtRepo.coursesBoughtSearch(
        params: request,
      );
      if (response.code == 200) {
        state = AsyncValue.data(response.data);
      } else {
        print(
          ">> Search failed with code: ${response.code}, msg: ${response.msg}",
        );
        state = AsyncValue.data([]);
      }
    } catch (e) {
      print(">> Search error: $e");
      state = AsyncValue.data([]);
    }
  }

  Future<void> reloadCourses() async {
    final response = await CoursesBoughtRepo.coursesBought();
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
    } else {
      state = AsyncValue.data([]);
    }
  }
}

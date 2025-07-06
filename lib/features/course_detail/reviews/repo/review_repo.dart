// lib/features/course_detail/reviews/repo/review_repo.dart

import 'package:flutter_ulearning_app/common/models/review_entities.dart';
import 'package:flutter_ulearning_app/common/services/http_until.dart';

class ReviewRepo {
  /// GET /api/courses/{courseId}/reviews
  static Future<ReviewListResponseEntity> getReviews(int courseId) async {
    final resp = await HttpUtil().get("/api/courses/$courseId/reviews");
    return ReviewListResponseEntity.fromJson(resp);
  }

  /// POST /api/courses/{courseId}/reviews
  static Future<ReviewPostResponseEntity> postReview({
    required int courseId,
    required ReviewRequestEntity params,
  }) async {
    final resp = await HttpUtil().post(
      "/api/courses/$courseId/reviews",
      data: params.toJson(),
    );
    return ReviewPostResponseEntity.fromJson(resp);
  }

  static Future<void> deleteReview({
    required int courseId,
    required int reviewId,
  }) async {
    await HttpUtil().delete("/api/courses/$courseId/reviews/$reviewId");
  }
}

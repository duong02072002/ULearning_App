// lib/features/course_detail/reviews/controller/review_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/common/models/review_entities.dart';
import '../repo/review_repo.dart';

/// FutureProvider.family để fetch danh sách review theo courseId
final reviewListProvider = FutureProvider.family<List<ReviewItem>, int>((
  ref,
  courseId,
) async {
  final resp = await ReviewRepo.getReviews(courseId);
  return resp.data;
});

final deleteReviewProvider = FutureProvider.family<void, Map<String, int>>((
  ref,
  params,
) async {
  final courseId = params['courseId']!;
  final reviewId = params['reviewId']!;
  await ReviewRepo.deleteReview(courseId: courseId, reviewId: reviewId);
  ref.invalidate(reviewListProvider(courseId));
});

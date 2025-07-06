import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/common/utils/constants.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/common/widgets/button_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import '../repo/review_repo.dart';
import 'package:flutter_ulearning_app/features/course_detail/reviews/controller/review_controller.dart';
import 'package:flutter_ulearning_app/common/models/review_entities.dart';

class ReviewSection extends ConsumerStatefulWidget {
  final int courseId;
  final int initialRatingCount;
  final double initialScore;
  final bool canReview;
  final String currentUserToken;

  const ReviewSection({
    Key? key,
    required this.courseId,
    required this.initialRatingCount,
    required this.initialScore,
    required this.canReview,
    required this.currentUserToken,
  }) : super(key: key);

  @override
  ConsumerState<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends ConsumerState<ReviewSection> {
  int _rating = 5;
  final _commentCtrl = TextEditingController();
  bool _submitting = false;
  late int _ratingCount;
  late double _score;

  @override
  void initState() {
    super.initState();
    _ratingCount = widget.initialRatingCount;
    _score = widget.initialScore;
  }

  Future<void> _submitReview() async {
    setState(() => _submitting = true);
    final resp = await ReviewRepo.postReview(
      courseId: widget.courseId,
      params: ReviewRequestEntity(
        rating: _rating,
        comment: _commentCtrl.text.isEmpty ? null : _commentCtrl.text,
      ),
    );
    setState(() {
      _ratingCount = resp.ratingCount;
      _score = resp.score;
      _submitting = false;
      _commentCtrl.clear();
    });
    ref.invalidate(reviewListProvider(widget.courseId));
  }

  Widget _starPicker() {
    return Row(
      children: List.generate(5, (i) {
        final idx = i + 1;
        return IconButton(
          icon: Icon(
            _rating >= idx ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () => setState(() => _rating = idx),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reviewsAsync = ref.watch(reviewListProvider(widget.courseId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ★ Header: average score + count
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber),
            const SizedBox(width: 8),
            Text16Normal(
              text: _score.toStringAsFixed(1),
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(width: 16),
            Text14Normal(
              text: "($_ratingCount đánh giá)",
              color: AppColors.primarySecondaryElementText,
            ),
          ],
        ),

        const Divider(height: 14, color: AppColors.primaryFourthElementText),

        // Nếu chưa mua → cảnh báo đỏ
        if (!widget.canReview)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text14Normal(
                text: "Bạn phải mua khoá học mới được đánh giá",
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else ...[
          // Form chọn sao
          Text14Normal(
            text: "Chọn sao:",
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
          _starPicker(),
          const SizedBox(height: 12),

          // Comment box
          Container(
            decoration: appBoxDecorationTextField(),
            child: TextField(
              controller: _commentCtrl,
              minLines: 2,
              maxLines: 4,
              style: TextStyle(color: AppColors.primaryText),
              decoration: InputDecoration(
                hintText: "Viết bình luận (tuỳ chọn)",
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Nút Gửi
          AppButton(
            buttonName: "Gửi đánh giá",
            isLogin: true,
            isDisable: _submitting,
            func: _submitting ? null : _submitReview,
          ),

          //const Divider(height: 40, color: AppColors.primaryFourthElementText),
        ],
        const Divider(height: 10, color: AppColors.primaryFourthElementText),

        // Danh sách review
        reviewsAsync.when(
          data: (list) {
            if (list.isEmpty) {
              return const Text14Normal(
                text: "Chưa có đánh giá nào.",
                color: AppColors.primarySecondaryElementText,
              );
            }
            return Column(
              children:
                  list.map((r) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: AppColors.primaryBackground,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            '${AppConstants.IMAGE_UPLOADS_PATH}${r.user.avatar}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text14Normal(
                            text: r.user.name,
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 8),
                          ...List.generate(5, (i) {
                            return Icon(
                              i < r.rating ? Icons.star : Icons.star_border,
                              size: 18,
                              color: Colors.amber,
                            );
                          }),
                        ],
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (r.comment != null)
                              Text14Normal(
                                text: r.comment!,
                                color: AppColors.primaryText,
                              ),
                            const SizedBox(height: 4),
                            Text(
                              r.createdAt.toLocal().toString().split('.')[0],
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.primarySecondaryElementText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing:
                          r.user.token == widget.currentUserToken
                              ? IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  await ref.read(
                                    deleteReviewProvider({
                                      'courseId': widget.courseId,
                                      'reviewId': r.id,
                                    }).future,
                                  );
                                },
                              )
                              : null,
                    );
                  }).toList(),
            );
          },
          loading:
              () => const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.primaryElement,
                    ),
                  ),
                ),
              ),
          error:
              (e, _) =>
                  Text14Normal(text: "Lỗi tải đánh giá: $e", color: Colors.red),
        ),
      ],
    );
  }
}

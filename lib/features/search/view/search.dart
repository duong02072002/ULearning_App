// lib/features/search/view/search.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/common/models/search_filter.dart';
import 'package:flutter_ulearning_app/common/widgets/app_bar.dart';
import 'package:flutter_ulearning_app/common/widgets/app_textfields.dart';
import 'package:flutter_ulearning_app/common/widgets/course_tile_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/filter_sheet.dart';
import 'package:flutter_ulearning_app/common/widgets/search_widgets.dart';
import '../controller/courses_search_controller.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  SearchFilter _filter = SearchFilter(); // ✅ thêm dòng này
  /// Mở modal filter
  void _openFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder:
          (_) => FilterSheet(
            search: _filter.search, // ✅ truyền search hiện tại
            onApply: (newFilter) {
              _filter = newFilter.copyWith(search: _filter.search);
              ref
                  .read(coursesSearchControllerProvider.notifier)
                  .applyFilter(_filter);
            },
          ),
    );
  }

  /// Tự động refresh khi quay lại trang
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(() {
      ref.read(coursesSearchControllerProvider.notifier).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(coursesSearchControllerProvider);

    return Scaffold(
      appBar: buildGlobalAppbar(title: "Search Courses"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar với filter button
            AppSearchBar(
              func: _openFilter,
              searchFunc: (value) {
                _filter = _filter.copyWith(
                  search: value,
                ); // ✅ Giữ lại các filter khác
                ref
                    .read(coursesSearchControllerProvider.notifier)
                    .applyFilter(_filter);
              },
            ),

            const SizedBox(height: 16),

            // Kết quả tìm kiếm
            Expanded(
              child: async.when(
                data: (resp) {
                  final list = resp?.data.items ?? [];
                  if (list.isEmpty) {
                    return const Center(child: Text('No courses found'));
                  }
                  return CourseTileWidgets(value: list);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

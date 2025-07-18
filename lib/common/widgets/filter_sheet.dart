// lib/features/search/view/filter_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/features/search/controller/courses_search_controller.dart';
import '../../common/models/search_filter.dart';
import '../../common/models/course_type_entity.dart';

/// A bottom-sheet widget for selecting search filters (categories, price, rating, duration)
class FilterSheet extends ConsumerStatefulWidget {
  final void Function(SearchFilter) onApply;
  final String? search; // ✅ thêm search vào props

  const FilterSheet({required this.onApply, this.search, Key? key})
    : super(key: key);

  @override
  ConsumerState<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<FilterSheet> {
  // Selected filter values
  final Set<int> _selCats = {};
  int? _selPrice;
  double? _selRating;
  int? _selDur;

  @override
  Widget build(BuildContext context) {
    // Fetch categories from repo via provider or directly
    final catsAsync = ref.watch(categoriesProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Search Filter',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Categories (from API)
              const Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              catsAsync.when(
                data:
                    (cats) => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          cats.map((CourseTypeEntity cat) {
                            final selected = _selCats.contains(cat.id);
                            return ChoiceChip(
                              label: Text(cat.title),
                              selected: selected,
                              onSelected:
                                  (v) => setState(() {
                                    if (v)
                                      _selCats.add(cat.id);
                                    else
                                      _selCats.remove(cat.id);
                                  }),
                            );
                          }).toList(),
                    ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => const Text('Failed to load categories'),
              ),
              const SizedBox(height: 24),

              // Price Range
              const Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children:
                    [
                      '\$0-10',
                      '\$10-20',
                      '\$20-30',
                      '\$30-40',
                      '\$40-50',
                      '> \$50',
                    ].asMap().entries.map((entry) {
                      final i = entry.key;
                      final label = entry.value;
                      final selected = _selPrice == i;
                      return ChoiceChip(
                        label: Text(label),
                        selected: selected,
                        onSelected:
                            (v) => setState(() => _selPrice = v ? i : null),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 24),

              // Rating
              const Text(
                'Rating',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children:
                    [3.0, 3.5, 4.0, 4.5].map((score) {
                      final selected = _selRating == score;
                      return ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text('> ${score.toStringAsFixed(1)}'),
                          ],
                        ),
                        selected: selected,
                        selectedColor: Theme.of(context).primaryColor,
                        onSelected:
                            (v) =>
                                setState(() => _selRating = v ? score : null),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 24),

              // Duration
              const Text(
                'Duration',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children:
                    ['0-10', '10-20', '20-30'].asMap().entries.map((entry) {
                      final i = entry.key;
                      final label = entry.value;
                      final selected = _selDur == i;
                      return ChoiceChip(
                        label: Text('$label Lessons'),
                        selected: selected,
                        onSelected:
                            (v) => setState(() => _selDur = v ? i : null),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 32),

              // Apply & Clear Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Map price index to actual ranges
                        double? minPrice;
                        double? maxPrice;
                        switch (_selPrice) {
                          case 0:
                            minPrice = 0;
                            maxPrice = 10;
                            break;
                          case 1:
                            minPrice = 10;
                            maxPrice = 20;
                            break;
                          case 2:
                            minPrice = 20;
                            maxPrice = 30;
                            break;
                          case 3:
                            minPrice = 30;
                            maxPrice = 40;
                            break;
                          case 4:
                            minPrice = 40;
                            maxPrice = 50;
                            break;
                          case 5:
                            minPrice = 50;
                            maxPrice = null;
                            break;
                          default:
                            minPrice = null;
                            maxPrice = null;
                        }

                        final filter = SearchFilter(
                          search:
                              widget.search, // ✅ giữ nguyên từ khóa tìm kiếm
                          categories: _selCats.toList(),
                          minPrice: minPrice,
                          maxPrice: maxPrice,
                          minScore: _selRating,
                          minLessons: _selDur != null ? _selDur! * 10 : null,
                          maxLessons:
                              _selDur != null ? (_selDur! + 1) * 10 : null,
                        );

                        widget.onApply(filter);
                        Navigator.pop(context);
                      },
                      child: const Text('Apply Filter'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selCats.clear();
                        _selPrice = null;
                        _selRating = null;
                        _selDur = null;
                      });
                    },
                    child: const Text('Clear All'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

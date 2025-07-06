import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/widgets/course_tile_widgets.dart';

class CoursesSearchWidgets extends ConsumerWidget {
  final List<CourseItem> value;
  const CoursesSearchWidgets({super.key, required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CourseTileWidgets(value: value);
  }
}

// lib/common/widgets/app_search_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import '../utils/app_colors.dart';

class AppSearchBar extends StatefulWidget {
  /// searchFunc: callback khi tìm với từ khóa
  final void Function(String)? searchFunc;

  /// func: callback khi mở filter sheet
  final VoidCallback? func;

  const AppSearchBar({this.searchFunc, this.func, Key? key}) : super(key: key);

  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _doSearch() {
    final text = _controller.text.trim();
    if (widget.searchFunc != null) widget.searchFunc!(text);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Input + Search button
        Expanded(
          child: Container(
            height: 40,
            decoration: appBoxShadow(
              color: AppColors.primaryBackground,
              boxBorder: Border.all(color: AppColors.primaryFourthElementText),
            ),
            child: Row(
              children: [
                SizedBox(width: 12),
                const AppImage(imagePath: ImageRes.searchIcon),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _doSearch(),
                    decoration: const InputDecoration(
                      hintText: 'Search your course...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _doSearch,
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(right: 8),
                    decoration: appBoxShadow(
                      boxBorder: Border.all(color: AppColors.primaryElement),
                    ),
                    child: const AppImage(imagePath: ImageRes.searchButton),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Filter button: only if func != null
        if (widget.func != null) ...[
          SizedBox(width: 8),
          GestureDetector(
            onTap: widget.func,
            child: Container(
              width: 40,
              height: 40,
              decoration: appBoxShadow(
                boxBorder: Border.all(color: AppColors.primaryElement),
              ),
              child: const Icon(Icons.filter_list, color: Colors.white),
            ),
          ),
        ],
      ],
    );
  }
}

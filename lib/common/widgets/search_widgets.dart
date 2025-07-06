import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/common/widgets/app_textfields.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import '../utils/app_colors.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key, this.func, this.searchFunc});

  final VoidCallback? func;
  final void Function(String? value)? searchFunc;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Search box
        Container(
          width: 280,
          height: 40,
          decoration: appBoxShadow(
            color: AppColors.primaryBackground,
            boxBorder: Border.all(color: AppColors.primaryFourthElementText),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 17),
                child: const AppImage(imagePath: ImageRes.searchIcon),
              ),
              SizedBox(
                width: 240,
                height: 40,
                child: AppTextFieldOnly(
                  controller: _controller,
                  search: true,
                  func: widget.searchFunc,
                  width: 240,
                  height: 40,
                  hintText: "Search your course...",
                ),
              ),
            ],
          ),
        ),

        // Search button
        GestureDetector(
          onTap: () {
            if (widget.searchFunc != null) {
              widget.searchFunc!(_controller.text);
            }
            if (widget.func != null) {
              widget.func!();
            }
          },
          child: Container(
            padding: EdgeInsets.all(5),
            width: 40,
            height: 40,
            decoration: appBoxShadow(
              boxBorder: Border.all(color: AppColors.primaryElement),
            ),
            child: const AppImage(imagePath: ImageRes.searchButton),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/utils/constants.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/features/profile/controller/profile_controller.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileImage = ref.read(profileControllerProvider);
        return Container(
          alignment: Alignment.bottomRight,
          width: 80,
          height: 80,
          decoration:
              profileImage.avatar == null
                  ? BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage(ImageRes.headPic),
                    ),
                  )
                  : BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        "${AppConstants.IMAGE_UPLOADS_PATH}${profileImage.avatar}",
                      ),
                    ),
                  ),
          child: AppImage(width: 25, height: 25, imagePath: ImageRes.editImage),
        );
      },
    );
  }
}

class ProfileNameWidget extends StatelessWidget {
  const ProfileNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileName = ref.read(profileControllerProvider);
        return Container(
          margin: EdgeInsets.only(top: 12),
          child: Text13Normal(
            text: profileName.name != null ? "${profileName.name}" : "",
          ),
        );
      },
    );
  }
}

class ProfileDescriptionWidget extends StatelessWidget {
  const ProfileDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileName = ref.read(profileControllerProvider);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          margin: EdgeInsets.only(top: 5, bottom: 10),
          // child: Text9Normal(
          //   text:
          //       profileName.description != null
          //           ? "${profileName.description}"
          //           : "I am awesome. I have been working as Flutter developer for the last five years. I fell in Love with Flutter. I feel like Flutter is going to take over the tech world and integrate awesome features in it.",
          //   color: AppColors.primarySecondaryElementText,
          // ),
        );
      },
    );
  }
}

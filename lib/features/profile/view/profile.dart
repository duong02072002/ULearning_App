import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/widgets/app_bar.dart';
import 'package:flutter_ulearning_app/features/profile/widget/profile_courses.dart';
import 'package:flutter_ulearning_app/features/profile/widget/profile_list_items.dart';
import 'package:flutter_ulearning_app/features/profile/widget/profile_widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildGlobalAppbar(title: "Profile"),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImageWidget(),
              ProfileNameWidget(),
              ProfileDescriptionWidget(),
              //ProfileCourses(),
              ProfileListItems(),
            ],
          ),
        ),
      ),
    );
  }
}

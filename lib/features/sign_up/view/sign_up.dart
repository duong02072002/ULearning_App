import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/common/global_loader/global_loader.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/app_bar.dart';
import 'package:flutter_ulearning_app/common/widgets/app_textfields.dart';
import 'package:flutter_ulearning_app/common/widgets/button_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/features/sign_in/view/widgets/sign_in_widgets.dart';
import 'package:flutter_ulearning_app/features/sign_up/provider/register_notifier.dart';
import 'package:flutter_ulearning_app/features/sign_up/controller/sign_up_controller.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  late SignUpController _controller;

  @override
  void initState() {
    _controller = SignUpController(ref: ref);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final regProvider = ref.watch(registerNotifierProvider);
    //regProvider.
    final loader = ref.watch(appLoaderProvider);
    // print(loader);
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppbar(title: "Sign Up"),
          backgroundColor: Colors.white,
          body:
              loader == false
                  ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        //More login options message
                        Center(
                          child: Text14Normal(
                            text: "Enter your details below & free sign up",
                          ),
                        ),
                        SizedBox(height: 50),
                        //User name text box
                        appTextField(
                          text: "User name",
                          iconName: ImageRes.user,
                          hintText: "Enter your user name",
                          func:
                              (value) => ref
                                  .read(registerNotifierProvider.notifier)
                                  .onUserNameChange(value),
                        ),
                        SizedBox(height: 20),
                        //Email text box
                        appTextField(
                          text: "Email",
                          iconName: ImageRes.user,
                          hintText: "Enter your email address",
                          func:
                              (value) => ref
                                  .read(registerNotifierProvider.notifier)
                                  .onUserEmailChange(value),
                        ),
                        SizedBox(height: 20),
                        //Password text box
                        appTextField(
                          text: "Password",
                          iconName: ImageRes.lock,
                          hintText: "Enter your password",
                          obscureText: true,
                          func:
                              (value) => ref
                                  .read(registerNotifierProvider.notifier)
                                  .onUserPasswordChange(value),
                        ),
                        SizedBox(height: 20),
                        //Confirm password text box
                        appTextField(
                          text: "Confirm Password",
                          iconName: ImageRes.lock,
                          hintText: "Enter your Confirm Password",
                          obscureText: true,
                          func:
                              (value) => ref
                                  .read(registerNotifierProvider.notifier)
                                  .onUserRePasswordChange(value),
                        ),
                        SizedBox(height: 20),
                        //Forgot text
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 25),
                          child: Text14Normal(
                            text:
                                "By creating an account you have to agree with our them & condication",
                          ),
                        ),
                        SizedBox(height: 80),

                        //App register button
                        Center(
                          child: appButton(
                            buttonName: "Register",
                            isLogin: true,
                            context: context,
                            func: () => _controller.handleSignUp(),
                          ),
                        ),
                      ],
                    ),
                  )
                  : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      color: AppColors.primaryElement,
                    ),
                  ),
        ),
      ),
    );
  }
}

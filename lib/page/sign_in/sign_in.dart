import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/widgets/button_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/page/sign_in/widgets/sign_in_widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppbar(),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Top login buttons
                thirdPartyLogin(),
                //More login options message
                Center(
                  child: text14Normal(
                    text: "Or use your email account to login",
                  ),
                ),
                SizedBox(height: 50),
                //Email text box
                appTextField(
                  text: "Email",
                  iconName: "assets/icons/user.png",
                  hintText: "Enter your email address",
                ),
                SizedBox(height: 20),
                //Password text box
                appTextField(
                  text: "Password",
                  iconName: "assets/icons/lock.png",
                  hintText: "Enter your password",
                  obscureText: true,
                ),
                SizedBox(height: 20),
                //Forgot text
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: textUnderline(text: "Forgot password?"),
                ),
                SizedBox(height: 100),
                //App login button
                Center(child: appButton(buttonName: "Login")),
                SizedBox(height: 20),
                //App register button
                Center(
                  child: appButton(buttonName: "Register", isLogin: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

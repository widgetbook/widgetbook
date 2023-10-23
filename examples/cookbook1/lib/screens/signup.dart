import 'package:cookbook1/riverpod/auth_riverpod.dart';
import 'package:cookbook1/screens/components/custom_button.dart';
import 'package:cookbook1/screens/components/custom_image.dart';

import 'package:cookbook1/screens/components/custom_textform_field.dart';
import 'package:cookbook1/screens/components/custom_title_text.dart';
import 'package:cookbook1/screens/home.dart';
import 'package:cookbook1/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends ConsumerWidget {
  SignUp({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const CustomTitleText(
          titleText: "SignUp",
          titleTextColor: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const CustomImage(
              height: 200,
              width: 200,
            ),
            Expanded(
              child: Container(
                color: AppColor.appRedColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          key: const Key('nameTextField'),
                          controller: nameController,
                          hintText: "username",
                          textFieldColor: AppColor.myWhite,
                          suffixIcon: Icons.person,
                          obscureText: false,
                        ),
                        CustomTextFormField(
                          key: const Key('emailTextField'),
                          controller: emailController,
                          hintText: "Email",
                          textFieldColor: AppColor.myWhite,
                          suffixIcon: Icons.email,
                          obscureText: false,
                        ),
                        CustomTextFormField(
                          key: const Key('passwordTextField'),
                          controller: passController,
                          hintText: "Password",
                          textFieldColor: AppColor.myWhite,
                          suffixIcon: Icons.lock,
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          key: Key("signUpButton"),
                          buttonTitle: "Sign Up",
                          buttonbackColor: AppColor.myWhite,
                          onPressed: () {
                            authNotifier
                                .signUpUserWithFirebase(
                              emailController.text,
                              passController.text,
                              nameController.text,
                            )
                                .then((value) {
                              if (value?.user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Home()),
                                );
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

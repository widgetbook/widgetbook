import 'package:cookbook1/riverpod/auth_riverpod.dart';
import 'package:cookbook1/screens/components/custom_form.dart';
import 'package:cookbook1/screens/components/custom_image.dart';
import 'package:cookbook1/screens/components/custom_title_text.dart';
import 'package:cookbook1/screens/home.dart';
import 'package:cookbook1/screens/signup.dart';
import 'package:cookbook1/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifer = ref.read(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const CustomTitleText(
          titleText: "LoginPage",
          titleTextColor: AppColor.myWhite,
        ),
      ),
      body: Column(
        children: [
          const CustomImage(
            height: 300,
            width: 300,
          ),
          Text(
            "Welcome to Cookbook",
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          Expanded(
            flex: 2,
            child: LoginForm(
              key: key,
              buttonTitle: "Login",
              emailController: emailController,
              passController: passController,
              formAssetColor: AppColor.myWhite,
              onPressed: () {
                authNotifer
                    .loginUserWithFirebase(
                  emailController.text,
                  passController.text,
                )
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Home(),
                    ),
                  );
                });
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignUp()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

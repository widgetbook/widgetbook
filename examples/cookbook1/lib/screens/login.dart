import 'package:cookbook1/notifier/auth_notifier.dart';
import 'package:cookbook1/screens/components/custom_form.dart';
import 'package:cookbook1/screens/components/custom_image.dart';
import 'package:cookbook1/screens/components/custom_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifer = ref.read(authNotierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const CustomTitleText(
          titleText: "LoginPage",
          titleTextColor: Colors.white,
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
            child: 
            LoginForm(
              key: key,
              buttonTitle: "Login",
              emailController: emailController,
              passController: passController,
              formAssetColor: Colors.white,
              onPressed: () {
                authNotifer.login(
                  email: emailController.text,
                  password: passController.text,
                  context: context,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

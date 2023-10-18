import 'package:cookbook1/riverpod/auth_riverpod.dart';
import 'package:cookbook1/screens/components/custom_form.dart';
import 'package:cookbook1/screens/components/custom_image.dart';
import 'package:cookbook1/screens/components/custom_title_text.dart';
import 'package:cookbook1/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifer = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 244, 87, 73),
          title: const CustomTitleText(
            titleText: "LoginPage",
            titleTextColor: Colors.white,
          )),
      body: Center(
          child: Column(children: [
        const CustomImage(
          height: 300,
          width: 300,
        ),
        const Text(
          "Welcome to Cookbook",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        LoginForm(
            emailController: emailController,
            passController: passController,
            formAssetColor: Colors.white,
            onPressed: () {
              authNotifer
                  .loginUserWithFirebase(
                      emailController.text, passController.text)
                  .then((value) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Home()));
              });
            })
      ])),
    );
  }
}

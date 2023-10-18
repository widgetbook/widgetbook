import 'package:cookbook1/riverpod/auth_riverpod.dart';
import 'package:cookbook1/screens/components/custom_button.dart';
import 'package:cookbook1/screens/components/custom_image.dart';

import 'package:cookbook1/screens/components/custom_textform_field.dart';
import 'package:cookbook1/screens/components/custom_title_text.dart';
import 'package:cookbook1/screens/home.dart';
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
          leading: const BackButton(color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 244, 87, 73),
          title: const CustomTitleText(
            titleText: "SignUp",
            titleTextColor: Colors.white,
          )),
      body: Center(
          child: Column(children: [
        const CustomImage(
          height: 200,
          width: 200,
        ),
        Expanded(
          child: Container(
              color: const Color.fromARGB(255, 244, 87, 73),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: nameController,
                      hintText: "username",
                      textFieldColor: Colors.white,
                      suffixIcon: Icons.person,
                      obscureText: false,
                    ),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: "Email",
                      textFieldColor: Colors.white,
                      suffixIcon: Icons.email,
                      obscureText: false,
                    ),
                    CustomTextFormField(
                      controller: passController,
                      hintText: "Password",
                      textFieldColor: Colors.white,
                      suffixIcon: Icons.lock,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      buttonTitle: "Sign Up",
                      buttonbackColor: Colors.white,
                      onPressed: () {
                        authNotifier
                            .signUpUserWithFirebase(emailController.text,
                                passController.text, nameController.text)
                            .then((value) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const Home()));
                        });
                      },
                    ),
                  ],
                ),
              )),
        )
      ])),
    );
  }
}

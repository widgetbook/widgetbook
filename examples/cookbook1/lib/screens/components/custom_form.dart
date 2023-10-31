import 'package:cookbook1/screens/components/custom_button.dart';
import 'package:cookbook1/screens/components/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passController,
    required this.onPressed,
    required this.formAssetColor,
    required this.buttonTitle,
  });

  final TextEditingController emailController;
  final TextEditingController passController;

  final Color formAssetColor;
  final VoidCallback onPressed;

  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                key: const Key('emailTextField1'),
                controller: emailController,
                hintText: "Email",
                textFieldColor: formAssetColor,
                suffixIcon: Icons.email,
                obscureText: false,
              ),
              CustomTextFormField(
                key: const Key('passwordTextField1'),
                controller: passController,
                hintText: "Password",
                textFieldColor: formAssetColor,
                suffixIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                key: const Key('LoginButton1'),
                buttonTitle: buttonTitle,
                buttonbackColor: formAssetColor,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: LoginForm,
)
LoginForm defaultColor(BuildContext context) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  return LoginForm(
    emailController: emailController,
    buttonTitle: "Login",
    passController: passController,
    onPressed: () {},
    formAssetColor: Colors.white,
  );
}

@widgetbook.UseCase(
  name: 'grey color',
  type: LoginForm,
)
LoginForm blackColor(BuildContext context) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  return LoginForm(
    buttonTitle: "Login",
    emailController: emailController,
    passController: passController,
    onPressed: () {},
    formAssetColor: Colors.black
  );
}

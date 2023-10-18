
import 'package:cookbook1/screens/components/custom_button.dart';
import 'package:cookbook1/screens/components/custom_textform_field.dart';
import 'package:cookbook1/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passController,
    // required this.authNotifer,
    required this.onPressed,
    required this.formAssetColor,
  });

  final TextEditingController emailController;
  final TextEditingController passController;
  // AuthProvider authNotifer = AuthProvider();
  final Color formAssetColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          color: const Color.fromARGB(255, 244, 87, 73),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: emailController,
                  hintText: "Email",
                  textFieldColor: formAssetColor,
                  suffixIcon: Icons.email,
                  obscureText: false,
                ),
                CustomTextFormField(
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
                  buttonTitle: "Login",
                  buttonbackColor: formAssetColor,
                  onPressed: onPressed,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SignUp()));
                    },
                    child: Text(
                      "New user? Sign Up",
                      style: TextStyle(color: formAssetColor, fontSize: 15),
                    ))
              ],
            ),
          )),
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
      passController: passController,
      onPressed: () {},
      formAssetColor: Colors.white);
}

@widgetbook.UseCase(
  name: 'grey color',
  type: LoginForm,
)
LoginForm blackColor(BuildContext context) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  return LoginForm(
    emailController: emailController,
    passController: passController,
    onPressed: () {},
    formAssetColor: const Color.fromARGB(255, 72, 71, 71),
  );
}

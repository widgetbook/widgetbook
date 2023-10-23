import 'package:cookbook1/riverpod/auth_riverpod.dart';
import 'package:cookbook1/screens/components/custom_title_text.dart';
import 'package:cookbook1/screens/login.dart';
import 'package:cookbook1/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitleText(
          titleText: "Home Page",
          titleTextColor: AppColor.myWhite,
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final authNotifier = ref.watch(authProvider);
              return IconButton(
                onPressed: () {
                  authNotifier.logoutUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: AppColor.myWhite,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                "Welcome to Cookbook",
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

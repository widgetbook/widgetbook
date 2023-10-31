import 'package:cookbook1/notifier/auth_notifier.dart';
import 'package:cookbook1/screens/components/custom_title_text.dart';
import 'package:cookbook1/screens/login.dart';



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const CustomTitleText(
          titleText: "Home Page",
          titleTextColor: Colors.white,
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final authNotifier = ref.watch(authNotierProvider.notifier);
              return IconButton(
                onPressed: () {
                  authNotifier.logout(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              "Welcome to Cookbook",
              style: Theme.of(context).textTheme.titleSmall!,
            ),
          ),
        ],
      ),
    );
  }
}

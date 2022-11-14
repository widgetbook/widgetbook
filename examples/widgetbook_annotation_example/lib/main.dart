import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/app.dart';
import 'package:meal_app/blocs/meal/meal_bloc.dart';
import 'package:meal_app/repositories/meal_repository.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookAppBuilder()
Widget appBuilder2(BuildContext context, Widget child) {
  return Container();
}

void main() {
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (context) => MealRepository(),
      ),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<MealBloc>(
          create: (context) => MealBloc(
            mealRepository: context.read<MealRepository>(),
          )..add(
              LoadMeals(),
            ),
        ),
      ],
      child: App(),
    ),
  ));
}

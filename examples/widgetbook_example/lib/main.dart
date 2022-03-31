import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook_example/app.dart';
import 'package:widgetbook_example/blocs/meal/meal_bloc.dart';
import 'package:widgetbook_example/repositories/meal_repository.dart';

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

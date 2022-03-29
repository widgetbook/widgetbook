import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook_example/blocs/meal/meal_bloc.dart';
import 'package:widgetbook_example/models/meal.dart';
import 'package:widgetbook_example/widgets/meal_info.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BlocBuilder<MealBloc, MealState>(
            builder: (context, state) {
              List<Meal> meals = state.meals;
              return ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8,
                  );
                },
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  return MealInfo(
                    meal: meals[index],
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

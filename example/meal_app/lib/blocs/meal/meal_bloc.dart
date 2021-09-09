import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/repositories/meal_repository.dart';
import 'package:meta/meta.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository mealRepository;

  MealBloc({
    required this.mealRepository,
  }) : super(
          MealState(),
        );

  @override
  Stream<MealState> mapEventToState(
    MealEvent event,
  ) async* {
    if (event is LoadMeals) {
      yield MealState(
        meals: this.mealRepository.loadMeals(),
      );
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:step_counter/data/models/achievement.dart';
import 'package:step_counter/data/services/database_service.dart';
import 'package:step_counter/locator_service.dart';
import 'package:step_counter/presentation/common/snack_bar.dart';

abstract class Repository {
  Future<void> setCurrentCountSteps(String day, int count);
  Future<int> getCurrentCountStepsPerDay(String day);
  Future<List<Achievement>> getAllAchievements();
}

class RepositoryImpl implements Repository {
  DatabaseService databaseService;

  RepositoryImpl({required this.databaseService});

  @override
  Future<int> getCurrentCountStepsPerDay(String currentDay) async {
    try {
      final int steps =
          await databaseService.getCurrentCountStepsPerDay(currentDay);
      return steps;
    } on FirebaseException {
      return 0;
    }
  }

  @override
  Future<void> setCurrentCountSteps(String day, int count) async {
    await databaseService.setCurrentCountSteps(day, count);
  }

  @override
  Future<List<Achievement>> getAllAchievements() async {
    try {
      final List<Achievement> achievements =
          await databaseService.getAllAchievements();
      return achievements;
    } on FirebaseException {
      return [];
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:step_counter/data/models/achievement.dart';
import 'package:step_counter/data/services/database_service.dart';

abstract class Repository {
  Future<void> setCurrentCountSteps(String day, int count);
  Future<Map<String, int>> getCountAllSteps();
  Future<int?> getCurrentCountStepsPerDay(String day);
  Future<List<Achievement>> getAllAchievements();
  Future<void> setPrize(String prize, int point);
  Future<Map<String, int>> getPrizes();
}

class RepositoryImpl implements Repository {
  DatabaseService databaseService;

  RepositoryImpl({required this.databaseService});

  @override
  Future<Map<String, int>> getCountAllSteps() async {
    try {
      final Map<String, int> listAllSteps =
          await databaseService.getCountAllSteps();
      return listAllSteps;
    } on FirebaseException {
      return {};
    }
  }

  @override
  Future<int?> getCurrentCountStepsPerDay(String currentDay) async {
    try {
      final int? steps =
          await databaseService.getCurrentCountStepsPerDay(currentDay);
      return steps;
    } on FirebaseException {
      return 0;
    }
  }

  @override
  Future<void> setCurrentCountSteps(String day, int count) async {
    await databaseService.setOrUpdateCurrentCountSteps(day, count);
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

  @override
  Future<void> setPrize(String prize, int point) async {
    await databaseService.setPrize(prize, point);
  }

  @override
  Future<Map<String, int>> getPrizes() async {
    try {
      final Map<String, int> listPrizes = await databaseService.getPrizes();
      return listPrizes;
    } on FirebaseException {
      return {};
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:step_counter/data/models/achievement.dart';
import 'package:step_counter/locator_service.dart';
import 'package:collection/collection.dart';

class DatabaseService {
  final _stepsCountPerDayCollection =
      FirebaseFirestore.instance.collection('stepsPerDay');

  final _achievementsCollection =
      FirebaseFirestore.instance.collection('achievements');

  final _prizeCollection = FirebaseFirestore.instance.collection('prize');

  Future<void> setOrUpdateCurrentCountSteps(String day, int count) async {
    await _stepsCountPerDayCollection
        .doc(sl<FirebaseAuth>().currentUser?.uid)
        .update({day: count});
  }

  Future<void> setPrize(String prize, int point) async {
    await _prizeCollection
        .doc(sl<FirebaseAuth>().currentUser?.uid)
        .update({prize: point});
  }

  Future<Map<String, int>> getPrizes() async {
    Map<String, int> listPrizes = {};
    var snapshot = await _prizeCollection.get();
    for (var element in snapshot.docs) {
      listPrizes.addAll(element
          .data()
          .map((key, value) => MapEntry<String, int>(key.toString(), value)));
    }
    return listPrizes;
  }

  Future<Map<String, int>> getCountAllSteps() async {
    Map<String, int> listStepsPerDate = {};
    var snapshot = await _stepsCountPerDayCollection.get();
    for (var element in snapshot.docs) {
      listStepsPerDate.addAll(element
          .data()
          .map((key, value) => MapEntry<String, int>(key.toString(), value)));
    }
    return listStepsPerDate;
  }

  Future<int?> getCurrentCountStepsPerDay(String day) async {
    int? stepsToday = await _stepsCountPerDayCollection
        .doc(sl<FirebaseAuth>().currentUser?.uid)
        .get()
        .then((value) => value
            .data()!
            .entries
            .firstWhereOrNull((element) => element.key == day)
            ?.value);
    return stepsToday;
  }

  Future<List<Achievement>> getAllAchievements() async {
    var snapshot = await _achievementsCollection.get();
    List<Achievement> achievements = [];
    for (var achievement in snapshot.docs) {
      achievements.add(Achievement.fromJson(achievement.data()));
    }
    return achievements;
  }
}

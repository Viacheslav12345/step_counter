import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:step_counter/data/models/achievement.dart';
import 'package:step_counter/locator_service.dart';

class DatabaseService {
  final _stepsCountPerDayCollection =
      FirebaseFirestore.instance.collection('stepsPerDay');

  final _achievementsCollection =
      FirebaseFirestore.instance.collection('achievements');

  Future<void> setCurrentCountSteps(String day, int count) async {
    await _stepsCountPerDayCollection
        .doc(sl<FirebaseAuth>().currentUser?.uid)
        .set({day: count});
  }

  Future<int> getCurrentCountStepsPerDay(String day) async {
    return _stepsCountPerDayCollection
        .doc(sl<FirebaseAuth>().currentUser?.uid)
        .get()
        .then((value) => value
            .data()!
            .entries
            .firstWhere((element) => element.key == day)
            .value);
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

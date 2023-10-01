import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:step_counter/locator_service.dart';

class DatabaseService {
  final _stepsCountPerDayCollection =
      FirebaseFirestore.instance.collection('stepsPerDay');

  Future<void> setCurrentCountSteps(String day, int count) async {
    await _stepsCountPerDayCollection
        .doc(sl<FirebaseAuth>().currentUser?.uid)
        .set({day: count});
  }

  Future<int> getCurrentCountStepsPerDay(String day) async {
    return _stepsCountPerDayCollection
        .doc(sl<FirebaseAuth>().currentUser?.uid)
        .get()
        .then((value) => int.parse(
            value.data()!.keys.firstWhere((element) => element == day)));
  }
}

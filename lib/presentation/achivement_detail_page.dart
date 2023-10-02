import 'package:flutter/material.dart';
import 'package:step_counter/data/models/achievement.dart';
import 'package:step_counter/data/services/auth_service.dart';
import 'package:step_counter/locator_service.dart';

class AchievementDetailsPage extends StatelessWidget {
  final Achievement achievement;
  const AchievementDetailsPage({Key? key, required this.achievement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Center(
              child: IconButton(
                onPressed: () async {
                  await sl<AuthService>().logOut();
                },
                icon: const Icon(Icons.output),
              ),
            )
          ],
          title: const Text('Step Counter'),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Card(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  achievement.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(
                    fit: BoxFit.cover,
                    achievement.image,
                    height: 70,
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  achievement.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 30),
                ),
              ])),
        ));
  }
}

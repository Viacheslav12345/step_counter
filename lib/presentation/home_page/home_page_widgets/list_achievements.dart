import 'package:flutter/material.dart';
import 'package:step_counter/data/models/achievement.dart';
import 'package:step_counter/data/repository.dart';
import 'package:step_counter/locator_service.dart';

class AchievementsWidget extends StatefulWidget {
  const AchievementsWidget({Key? key}) : super(key: key);

  @override
  State<AchievementsWidget> createState() => _AchievementsWidgetState();
}

class _AchievementsWidgetState extends State<AchievementsWidget> {
  Future<List<Achievement>> getAllAchievements() async {
    listAchievements = await sl<Repository>().getAllAchievements();
    setState(() {});

    return listAchievements;
  }

  @override
  void initState() {
    super.initState();
    getAllAchievements();
  }

  List<Achievement> listAchievements = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listAchievements.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: Image.network(
                listAchievements[index].image,
                height: 70,
              ),
              title: Text(
                // 'testing',
                listAchievements[index].title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ));
        });
  }
}

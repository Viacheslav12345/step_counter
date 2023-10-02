import 'package:flutter/material.dart';
import 'package:step_counter/data/models/achievement.dart';
import 'package:step_counter/data/repository.dart';
import 'package:step_counter/locator_service.dart';
import 'package:step_counter/common/show_dialog.dart';
import 'package:step_counter/presentation/achivement_detail_page.dart';

class AchievementsWidget extends StatefulWidget {
  final int stepsPerWeek, stepsAll, stepsToday;
  const AchievementsWidget(
      {Key? key,
      required this.stepsPerWeek,
      required this.stepsAll,
      required this.stepsToday})
      : super(key: key);

  @override
  State<AchievementsWidget> createState() => _AchievementsWidgetState();
}

class _AchievementsWidgetState extends State<AchievementsWidget> {
  List<Achievement> listAchievements = [];
  Map<String, int> listPrizes = {};

  Future<List<Achievement>> getAllAchievementsAndPrizes() async {
    listAchievements = await sl<Repository>().getAllAchievements();
    listPrizes = await sl<Repository>().getPrizes();
    setState(() {});

    return listAchievements;
  }

  @override
  void initState() {
    super.initState();

    getAllAchievementsAndPrizes().then((value) => showPrize(context));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Available achievements',
          style: TextStyle(color: Colors.blueGrey, fontSize: 20),
        ),
        Flexible(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: listAchievements.length,
              itemBuilder: (BuildContext context, int index) {
                bool active =
                    listPrizes.containsKey(listAchievements[index].title);
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AchievementDetailsPage(
                              achievement: listAchievements[index],
                            )));
                  },
                  child: Card(
                      child: Container(
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: (!active) ? Colors.grey : null,
                            backgroundBlendMode:
                                (!active) ? BlendMode.saturation : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 20, top: 10, bottom: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    listAchievements[index].image,
                                    height: 70,
                                  ),
                                  Flexible(
                                    child: Text(
                                      listAchievements[index].title,
                                      style: const TextStyle(
                                          color: Colors.blueGrey, fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[100],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 10,
                                    width: 80,
                                    child: LinearProgressIndicator(
                                      semanticsValue: listAchievements[index]
                                          .point
                                          .toString(),
                                      value: widget.stepsToday /
                                          listAchievements[index]
                                              .point
                                              .toDouble(),
                                      minHeight: 8,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ]),
                          ))),
                );
              }),
        ),
      ],
    );
  }

  void showPrize(context) {
    if (listAchievements.isNotEmpty) {
      if (widget.stepsAll == 0) {
        if (!listPrizes.keys.contains(listAchievements[0].title)) {
          sl<Repository>()
              .setPrize(listAchievements[0].title, listAchievements[0].point);
          showOkDialog(
              title: 'Congrats!\nYou get first prize for registration!',
              imageUrl: listAchievements.first.image,
              context: context);
          setState(() {});
        }
      } else if (widget.stepsToday >= 1000 && widget.stepsToday <= 5000) {
        if (!listPrizes.keys.contains(listAchievements[1].title)) {
          showOkDialog(
              title: 'Congrats! You get prize for ${listAchievements[1].title}',
              imageUrl: listAchievements[1].image,
              context: context);
          sl<Repository>()
              .setPrize(listAchievements[1].title, listAchievements[1].point);
          setState(() {});
        }
      } else if (widget.stepsToday >= 5000 && widget.stepsToday <= 10000) {
        if (!listPrizes.keys.contains(listAchievements[2].title)) {
          showOkDialog(
              title: 'Congrats! You get prize for ${listAchievements[2].title}',
              imageUrl: listAchievements[2].image,
              context: context);
          sl<Repository>()
              .setPrize(listAchievements[2].title, listAchievements[2].point);
          setState(() {});
        }
      } else if (widget.stepsToday >= 10000) {
        if (!listPrizes.keys.contains(listAchievements[3].title)) {
          showOkDialog(
              title: 'Congrats! You get prize for ${listAchievements[3].title}',
              imageUrl: listAchievements[3].image,
              context: context);
          sl<Repository>()
              .setPrize(listAchievements[3].title, listAchievements[3].point);
          setState(() {});
        }
      } else if (widget.stepsPerWeek >= 3000 && widget.stepsPerWeek <= 10000) {
        if (!listPrizes.keys.contains(listAchievements[4].title)) {
          showOkDialog(
              title: 'Congrats! You get prize for ${listAchievements[4].title}',
              imageUrl: listAchievements[4].image,
              context: context);
          sl<Repository>()
              .setPrize(listAchievements[4].title, listAchievements[4].point);
          setState(() {});
        }
      } else if (widget.stepsPerWeek >= 10000 && widget.stepsPerWeek <= 20000) {
        if (!listPrizes.keys.contains(listAchievements[5].title)) {
          showOkDialog(
              title: 'Congrats! You get prize for ${listAchievements[5].title}',
              imageUrl: listAchievements[5].image,
              context: context);
          sl<Repository>()
              .setPrize(listAchievements[5].title, listAchievements[5].point);
          setState(() {});
        }
      } else if (widget.stepsPerWeek >= 20000) {
        if (!listPrizes.keys.contains(listAchievements[6].title)) {
          showOkDialog(
              title: 'Congrats! You get prize for ${listAchievements[6].title}',
              imageUrl: listAchievements[6].image,
              context: context);
          sl<Repository>()
              .setPrize(listAchievements[6].title, listAchievements[6].point);
          setState(() {});
        }
      }
    }
  }
}

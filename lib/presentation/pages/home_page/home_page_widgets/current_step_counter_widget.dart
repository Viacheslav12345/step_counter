import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:step_counter/data/repository.dart';
import 'package:step_counter/locator_service.dart';
import 'package:step_counter/presentation/home_page/home_page_widgets/list_achievements.dart';
import 'package:step_counter/presentation/home_page/home_page_widgets/radial_gauge_widget.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 10);
}

DateTime formatFromString(String d) {
  return DateTime.parse(d);
}

class CurrentStepCounterWidget extends StatefulWidget {
  const CurrentStepCounterWidget({Key? key}) : super(key: key);

  @override
  State<CurrentStepCounterWidget> createState() =>
      _CurrentStepCounterWidgetState();
}

class _CurrentStepCounterWidgetState extends State<CurrentStepCounterWidget> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '0';
  int _steps = 0;
  int stepPlan = 1000;
  String day = formatDate(DateTime.now());
  int stepsToday = 0;
  int savedStepToday = 0;
  int stepsPerWeek = 0;
  int stepsAll = 0;

  Future<int> getSteps() async {
    savedStepToday =
        await sl<Repository>().getCurrentCountStepsPerDay(day) ?? 0;

    final Map<String, int> stepsAllTime =
        await sl<Repository>().getCountAllSteps();
    DateTime today = DateTime.now();
    Map<String, int> listLastSevenDays = {};
    listLastSevenDays.addEntries(stepsAllTime.entries.where((element) =>
        today.difference(formatFromString(element.key)).inDays < 7));

    stepsPerWeek = listLastSevenDays.isNotEmpty
        ? listLastSevenDays.values.reduce((value, element) => value + element)
        : 0;

    stepsAll = stepsAllTime.isNotEmpty
        ? stepsAllTime.values.reduce((value, element) => value + element)
        : 0;

    return stepsAll;
  }

  void setStepsToday() {
    if (savedStepToday > _steps) {
      stepsToday = _steps + savedStepToday;
    } else {
      stepsToday = _steps;
    }

    sl<Repository>().setCurrentCountSteps(day, stepsToday);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getSteps().then((value) => setStepsToday());
  }

  void onStepCount(StepCount event) {
    print(event);
    _steps = event.steps;
    setStepsToday();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
  }

  void initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      _pedestrianStatusStream
          .listen(onPedestrianStatusChanged)
          .onError(onPedestrianStatusError);

      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(onStepCount).onError(onStepCountError);
    } else {}
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 250,
              child: RadialGaugeWidget(
                stepDayPlan: stepPlan,
                stepsToday: stepsToday,
              ),
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
              size: 70,
              color: _status == 'walking'
                  ? Colors.green[200]
                  : _status == 'stopped'
                      ? const Color.fromARGB(255, 140, 206, 245)
                      : Colors.transparent,
            ),
            const Divider(),
            Expanded(
                child: FutureBuilder(
                    future: getSteps(),
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.hasData) {
                        return AchievementsWidget(
                          stepsAll: stepsAll,
                          stepsPerWeek: stepsPerWeek,
                          stepsToday: stepsToday,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueGrey,
                          ),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

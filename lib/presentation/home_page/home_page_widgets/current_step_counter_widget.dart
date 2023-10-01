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

  Future<int> getStepsToday() async {
    stepsToday = await sl<Repository>().getCurrentCountStepsPerDay(day);
    setState(() {});

    return stepsToday;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getStepsToday();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps;
      if (_steps > stepsToday) {
        stepsToday = _steps;
      }
      day = formatDate(event.timeStamp);

      sl<Repository>().setCurrentCountSteps(day, _steps);
    });
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
    // setState(() {
    // _steps = '0';
    // 'Step Count not available';
    // });
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 250,
            child: RadialGaugeWidget(
              stepDayPlan: stepPlan,
              stepsToday: (stepsToday > _steps) ? stepsToday : _steps,
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
          const Expanded(child: AchievementsWidget())
        ],
      ),
    );
  }
}

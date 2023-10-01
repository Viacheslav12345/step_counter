import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGaugeWidget extends StatelessWidget {
  final int stepsToday;
  final int stepDayPlan;
  const RadialGaugeWidget({
    Key? key,
    required this.stepsToday,
    required this.stepDayPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      title: const GaugeTitle(
          text: 'Steps today',
          textStyle: TextStyle(color: Colors.grey, fontSize: 20)),
      axes: <RadialAxis>[
        RadialAxis(
          axisLineStyle: AxisLineStyle(
            color: Colors.grey[300],
            dashArray: const <double>[8, 2],
          ),
          minorTicksPerInterval: 0,
          maximum: 100,
          showLabels: false,
          annotations: [
            GaugeAnnotation(
              widget: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: '${stepsToday.toString()}\n',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text: '/\n',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  TextSpan(
                    text: '${stepDayPlan.toString()}\n',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ]),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          pointers: <GaugePointer>[
            RangePointer(
              value: ((stepsToday.toDouble()) / stepDayPlan) * 100,
              color: Theme.of(context).primaryColor,

              // Theme.of(context).primaryColor,
              dashArray: const <double>[8, 2],
            ),
          ],
        ),
      ],
    );
  }
}

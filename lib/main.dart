import 'package:flutter/material.dart';
import 'package:step_counter/counter_app.dart';
import 'package:step_counter/locator_service.dart' as di;
import 'package:step_counter/locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await sl.allReady();
  runApp(
    const CounterApp(),
  );
}

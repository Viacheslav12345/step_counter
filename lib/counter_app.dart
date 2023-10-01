import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_counter/data/models/person.dart';
import 'package:step_counter/data/services/auth_service.dart';
import 'package:step_counter/locator_service.dart';
import 'package:step_counter/presentation/landing_page.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Person?>.value(
        lazy: false,
        value: sl<AuthService>().currentUser,
        initialData: null,
        child: MaterialApp(
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blueGrey,
                primary: Colors.blueGrey,
              ),
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                  titleTextStyle:
                      TextStyle(color: Colors.grey[600], fontSize: 18)
                  // centerTitle: true,
                  )),
          home: const LandingPage(),
        ));
  }
}

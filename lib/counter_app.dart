import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_counter/data/models/achievement.dart';
import 'package:step_counter/data/models/person.dart';
import 'package:step_counter/data/services/auth_service.dart';
import 'package:step_counter/locator_service.dart';
import 'package:step_counter/presentation/achivement_detail_page.dart';
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
          debugShowCheckedModeBanner: false,
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
          routes: {
            '/': (context) => const LandingPage(),
            '/achievement_detail_screen': (context) {
              final arguments = ModalRoute.of(context)?.settings.arguments;
              if (arguments is Achievement) {
                return AchievementDetailsPage(achievement: arguments);
              } else {
                return AchievementDetailsPage(
                    achievement: Achievement(
                        image: 'image',
                        title: 'title',
                        description: 'description',
                        point: 0));
              }
            },
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_counter/data/models/person.dart';
import 'package:step_counter/data/services/auth_service.dart';
import 'package:step_counter/locator_service.dart';
import 'package:step_counter/presentation/auth_page/auth_page.dart';
import 'package:step_counter/presentation/home_page/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Person? user = Provider.of<Person?>(context);
    bool isLoggedIn = user != null;
    return isLoggedIn
        ? const HomePage()
        : AuthPage(authService: sl<AuthService>());
  }
}

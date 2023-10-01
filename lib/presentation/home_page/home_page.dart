import 'package:flutter/material.dart';
import 'package:step_counter/data/services/auth_service.dart';
import 'package:step_counter/locator_service.dart';
import 'package:step_counter/presentation/home_page/home_page_widgets/current_step_counter_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CurrentStepCounterWidget()],
        ),
      ),
    );
  }
}

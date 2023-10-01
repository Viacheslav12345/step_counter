import 'package:flutter/material.dart';
import 'package:step_counter/data/services/auth_service.dart';
import 'package:step_counter/locator_service.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Step Counter'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'COUNTER',
                style: TextStyle(fontSize: 40),
              ),
            )
          ],
        ),
      ),
    );
  }
}

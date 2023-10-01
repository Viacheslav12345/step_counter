import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:step_counter/data/repository.dart';
import 'package:step_counter/data/services/auth_service.dart';
import 'package:step_counter/data/services/database_service.dart';
import 'package:step_counter/firebase_options.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingletonAsync<FirebaseApp>(() =>
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));

  sl.registerSingletonWithDependencies<FirebaseAuth>(
      () => FirebaseAuth.instance,
      dependsOn: [FirebaseApp]);

  sl.registerSingletonWithDependencies<AuthService>(
      () => AuthService(fAuth: sl<FirebaseAuth>()),
      dependsOn: [FirebaseApp]);

  sl.registerSingletonWithDependencies(() => DatabaseService(),
      dependsOn: [FirebaseApp, FirebaseAuth]);

  sl.registerSingletonWithDependencies<Repository>(
      () => RepositoryImpl(databaseService: sl()),
      dependsOn: [DatabaseService]);
}

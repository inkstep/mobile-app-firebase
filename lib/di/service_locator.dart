import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:inkstep/utils/screen_navigator.dart';

GetIt sl = GetIt();

void setup() {
  sl.registerFactory<ScreenNavigator>(() => ScreenNavigator());
  sl.registerSingleton<FirebaseMessaging>(FirebaseMessaging());
}

void setupMocks() {
  sl.registerFactory<ScreenNavigator>(() => ScreenNavigator());
// DB
// DataSource
// Repository
// Bloc
}

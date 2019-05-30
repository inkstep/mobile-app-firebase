import 'package:get_it/get_it.dart';
import 'package:inkstep/utils/screen_navigator.dart';

GetIt sl = GetIt();

void setup() {
  sl.registerFactory<ScreenNavigator>(() => ScreenNavigator());
  // DB
  // DataSource
  // Repository
  // Bloc
}

void setupMocks() {
  sl.registerFactory<ScreenNavigator>(() => ScreenNavigator());
// DB
// DataSource
// Repository
// Bloc
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkstep/data/app_repository.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/domain/redux/app_reducer.dart';
import 'package:inkstep/theme.dart';
import 'package:inkstep/ui/pages/splash_screen.dart';
import 'package:redux/redux.dart';

import 'domain/redux/app_actions.dart';
import 'domain/redux/app_middleware.dart';
import 'domain/redux/app_state.dart';

void main() {
  // Set up Service Locator
  setup();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  runApp(Inkstep());
}

class Inkstep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Store<AppState>(
      appReducer,
      initialState: AppState.init(),
      middleware: [AppMiddleware(AppRepository())],
    );
    store.dispatch(VerifyAuthStatus());
    store.dispatch(LoadArtistSubscriptions());
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'SOUTHCITYMARKET',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: SplashScreen(),
      ),
    );
  }
}

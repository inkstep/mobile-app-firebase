import 'package:inkstep/data/app_repository.dart';
import 'package:inkstep/domain/redux/app_actions.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';

class AppMiddleware extends MiddlewareClass<AppState>{

  final AppRepository appRepository;

  AppMiddleware(this.appRepository);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is LoadArtistSubscriptions) {
      appRepository.getArtistSubscriptions('7qt3KSYbmIYP7yUJZf2NB7k5mvh2').listen(
          (data) => store.dispatch(LoadedArtistSubscriptions(data.expand((i) => i).toList()))
      );

    } else if (action is SubscribeToArtist) {
      await appRepository.subscribeToArtist(
        authUid: store.state.authUid,
        artistId: action.artistId,
      );

    } else if (action is UnsubscribeFromArtist) {
      await appRepository.unsubscribeFromArtist(
        authUid: store.state.authUid,
        artistId: action.artistId,
      );

    } else if (action is VerifyAuthStatus) {
      appRepository.getAuthenticationStateChange().listen((user) {
        if (user == null) {
          print('no user yet');
          store.dispatch(LoginAnonymously());
        } else {
          print('user: ${store.state.authUid}');
          store.dispatch(OnAuthentication(user));
          store.dispatch(ConnectToDataSource());
        }
      });
      print('listening to auth status changes');

    } else if (action is LoginAnonymously) {
      final authUid = await appRepository.signInAnonymously();
      store.dispatch(OnAuthentication(authUid));
      print('logged in anonymously');
    }
  }
}

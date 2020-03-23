import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inkstep/data/app_repository.dart';
import 'package:inkstep/domain/redux/app_actions.dart';
import 'package:inkstep/models/artist.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';

class AppMiddleware extends MiddlewareClass<AppState>{

  final AppRepository appRepository;

  AppMiddleware(this.appRepository);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is LoadArtistSubscriptions) {
      final List<int> ids = await appRepository.getArtistSubscriptions(store.state.authUid);
      store.dispatch(LoadedArtistSubscriptions(ids));

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
          store.dispatch(LoginAnonymously());
        } else {
          store.dispatch(OnAuthentication(user));
          store.dispatch(ConnectToDataSource());
        }
      });

    } else if (action is LoginAnonymously) {
      final authUid = await appRepository.signInAnonymously();
      store.dispatch(OnAuthentication(authUid));

    } else if (action is ConnectToDataSource) {
      // Dispatch all other load actions
      store.dispatch(LoadArtistSubscriptions());
    }
  }
}

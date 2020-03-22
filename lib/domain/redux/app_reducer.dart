import 'package:inkstep/domain/redux/app_actions.dart';

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is LoadArtistSubscriptions) {
    return state;
  } else if (action is UnsubscribeFromArtist) {
    return AppState(List.from(state.artistSubscriptions)..remove(action.artistId), state.authUid);
  } else if (action is SubscribeToArtist) {
    return AppState(List.from(state.artistSubscriptions)..add(action.artistId), state.authUid);
  } else if (action is LoadedArtistSubscriptions) {
    return AppState(action.artistIds, state.authUid);
  } else if (action is OnAuthentication) {
    return AppState(state.artistSubscriptions, action.uid);
  }
  return AppState([], null);
}

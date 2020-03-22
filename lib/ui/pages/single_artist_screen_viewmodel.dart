import 'package:inkstep/domain/redux/app_actions.dart';
import 'package:inkstep/domain/redux/app_state.dart';
import 'package:redux/redux.dart';

class ArtistScreenViewModel {
  final List<int> subscriptions;
  final void Function(int) subscribe;
  final void Function(int) unsubscribe;

  ArtistScreenViewModel(this.subscriptions, this.subscribe, this.unsubscribe);

  static ArtistScreenViewModel fromStore(Store<AppState> store) {
    return ArtistScreenViewModel(
      store.state.artistSubscriptions,
      (id) => store.dispatch(SubscribeToArtist(id)),
      (id) => store.dispatch(UnsubscribeFromArtist(id)),
    );
  }
}

class LoadArtistSubscriptions {}

class LoadedArtistSubscriptions {
  final List<int> artistIds;

  LoadedArtistSubscriptions(this.artistIds);
}

class SubscribeToArtist {
  final int artistId;

  SubscribeToArtist(this.artistId);
}

class UnsubscribeFromArtist {
  final int artistId;

  UnsubscribeFromArtist(this.artistId);
}

// Dispatch to listen to auth status from firebase
class VerifyAuthStatus {}

// Dispatch when we want to log in i.e. on load
class LoginAnonymously {}

// Dispatch these after authentication
class OnAuthentication {
  final String uid;

  OnAuthentication(this.uid);
}
class ConnectToDataSource{}

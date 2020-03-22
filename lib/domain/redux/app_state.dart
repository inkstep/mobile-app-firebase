class AppState {

  final List<int> artistSubscriptions;

  final String authUid;

  AppState(this.artistSubscriptions, this.authUid);

  factory AppState.init() {
    return AppState([], null);
  }
}

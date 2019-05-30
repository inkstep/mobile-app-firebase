import 'dart:async';
import 'dart:core';

// TODO(DJRHails): provide local file storage as well
class JourneysRepository {
  const JourneysRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  /// Loads journeys from a Web Client.
  Future<List<Map<String, dynamic>>> loadJourneys() async {
    return await webClient.fetchJourneys();
  }

  // Persists journeys to the web
  Future saveJourneys(List<Map<String, dynamic>> journeys) {
    return Future.wait<dynamic>([
      webClient.postJourneys(journeys),
    ]);
  }
}

class WebClient {
  const WebClient([this.delay = const Duration(milliseconds: 300)]);

  final Duration delay;

  Future<List<Map<String, dynamic>>> fetchJourneys() async {
    return Future.delayed(
      delay,
      () => [
            <String, dynamic>{
              'artist': 'Ricky',
              'studio': 'South City Market',
            },
          ],
    );
  }

  Future<bool> postJourneys(List<Map<String, dynamic>> journeys) async {
    print('trying to post');
    return Future.value(true);
  }
}

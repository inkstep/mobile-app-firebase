import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inkstep/resources/artists.dart';
import 'package:inkstep/ui/components/artist_card.dart';

class ArtistSelectionScreen extends StatefulWidget {
  const ArtistSelectionScreen({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ArtistSelectionScreenState();
}

class ArtistSelectionScreenState extends State<ArtistSelectionScreen> {
  http.Client _client;

  bool selected = false;

  @override
  void initState() {
    super.initState();
    _client = http.Client();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: offlineArtists.length,
        itemBuilder: (context, idx) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: ArtistCard(offlineArtists[idx], key: UniqueKey(),),
          );
        },
      );
  }
}

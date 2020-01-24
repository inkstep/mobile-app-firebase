import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/resources/artists.dart';
import 'package:inkstep/ui/components/artist_card.dart';

class ArtistSelectionScreen extends StatelessWidget {
  const ArtistSelectionScreen({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: offlineArtists.length,
      itemBuilder: (context, idx) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: ArtistCard(
            offlineArtists[idx],
            key: UniqueKey(),
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/artist.dart';
import 'package:inkstep/resources/artists.dart';
import 'package:inkstep/theme.dart';

class ArtistImage extends StatelessWidget {

  const ArtistImage(this.artist, {Key key}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: artist.profileImage,
      shape: CircleBorder(),
      elevation: 0,
      margin: EdgeInsets.all(10),
    );
  }
}

class ArtistCard extends StatelessWidget {

  const ArtistCard({Key key, this.artist}) : super(key: key);

  final Artist artist;

  List<Widget> buildItems(BuildContext context) {
    return <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ArtistImage(artist),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          artist.name,
          style: Theme.of(context).accentTextTheme.title,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
        child: Text(
          offlineStudios[artist.studioID].name,
          style: Theme.of(context).accentTextTheme.subtitle,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Card(
            color: Colors.black,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: artist.profileImage,
            shape: RoundedRectangleBorder(
              borderRadius: smallBorderRadius,
            ),
            elevation: 10,
            margin: EdgeInsets.all(10),
          ),
        ),
        Text(
          artist.name,
          style: Theme.of(context).textTheme.title,
        ),
        Text(
          offlineStudios[artist.studioID].name,
          style: Theme.of(context).textTheme.subtitle,
        )
      ],
    );
  }

}

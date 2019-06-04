import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/artists_bloc.dart';
import 'package:inkstep/blocs/artists_event.dart';
import 'package:inkstep/blocs/artists_state.dart';
import 'package:inkstep/resources/artists_repository.dart';
import 'package:inkstep/resources/web_client.dart';
import 'package:inkstep/ui/components/profile_row.dart';

class ArtistSelectionScreen extends StatefulWidget {
  ArtistSelectionScreen({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ArtistSelectionScreenState();
}

class ArtistSelectionScreenState extends State<ArtistSelectionScreen> {
  final ArtistsBloc _artistsBloc =
      ArtistsBloc(artistsRepository: ArtistsRepository(webClient: WebClient()));

  @override
  void initState() {
    _artistsBloc.dispatch(LoadArtists(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArtistsBloc>(
        bloc: _artistsBloc,
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            title: Text('Select an Artist'),
          ),
          body: BlocBuilder(
            bloc: _artistsBloc,
            builder: (BuildContext context, ArtistsState state) {
              if (state is ArtistsUninitialised) {
                return Container();
              } else if (state is ArtistsLoaded) {
                return Container(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        if (state.artists.isEmpty) {
                          return Container();
                        }
                        return ProfileRow(
                            name: state.artists[index].name,
                            studioName: state.artists[index].studio,
                            imagePath: 'assets/ricky.png');
                      },
                    ));
              }
            },
          ),
        ));
  }

  @override
  void dispose() {
    _artistsBloc.dispose();
    super.dispose();
  }
}

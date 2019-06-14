import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:inkstep/blocs/artists_bloc.dart';
import 'package:inkstep/blocs/artists_event.dart';
import 'package:inkstep/blocs/artists_state.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/resources/artists_repository.dart';
import 'package:inkstep/resources/web_repository.dart';
import 'package:inkstep/ui/components/profile_row.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class ArtistSelectionScreen extends StatefulWidget {
  ArtistSelectionScreen({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ArtistSelectionScreenState();
}

class ArtistSelectionScreenState extends State<ArtistSelectionScreen> {
  http.Client _client;
  ArtistsBloc _artistsBloc;

  @override
  void initState() {
    _client = http.Client();
    _artistsBloc = ArtistsBloc(
      artistsRepository: ArtistsRepository(
        webClient: WebRepository(client: _client),
      ),
    );
    _artistsBloc.dispatch(LoadArtists(0));
    super.initState();
  }

  @override
  void dispose() {
    _client.close();
    _artistsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArtistsBloc>(
        bloc: _artistsBloc,
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            title: Text('Who was your artist?'),
          ),
          body: BlocBuilder(
            bloc: _artistsBloc,
            builder: (BuildContext context, ArtistsState state) {
              if (state is ArtistsUninitialised) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).backgroundColor),
                  ),
                );
              } else if (state is ArtistsLoaded) {
                return Container(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                    child: ListView.builder(
                      itemCount: state.artists.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (state.artists.isEmpty) {
                          return Container();
                        }
                        return InkWell(
                          onTap: () {
                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                            nav.openNewJourneyScreen(context, state.artists[index].artistID);
                          },
                          child: ProfileRow(
                            name: state.artists[index].name,
                            studioName: state.artists[index].studio.name,
                            imagePath: null,
                            artistID: state.artists[index].artistID,
                          ),
                        );
                      },
                    ));
              }
            },
          ),
        ));
  }
}

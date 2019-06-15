import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:inkstep/blocs/artists_bloc.dart';
import 'package:inkstep/blocs/artists_event.dart';
import 'package:inkstep/blocs/artists_state.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/resources/artists_repository.dart';
import 'package:inkstep/resources/web_repository.dart';
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

  bool selected = false;

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
          body: BlocBuilder(
            bloc: _artistsBloc,
            builder: (BuildContext context, ArtistsState state) {
              if (state is ArtistsUninitialised) {
                return Container(
                  color: Theme.of(context).backgroundColor,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).cardColor),
                    ),
                  ),
                );
              } else if (state is ArtistsLoaded) {
                return Container(
                  color: Theme.of(context).backgroundColor,
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "So who's the lucky artist?",
                            style: Theme.of(context).textTheme.title.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: LayoutBuilder(
                            builder: (context, constraint) {
                              final height = constraint.maxHeight;
                              final width = constraint.maxWidth;
                              final double offset = selected ? 0.0 : -width * 0.10;
                              return Swiper(
                                  loop: true,
                                  viewportFraction: 0.7,
                                  itemCount: state.artists.length,
                                  layout: SwiperLayout.CUSTOM,
                                  customLayoutOption:
                                      CustomLayoutOption(startIndex: 0, stateCount: 5).addTranslate(
                                    [
                                      Offset(-width * 0.75 * 2 + offset, 0.0),
                                      Offset(-width * 0.75 + offset, height * 0.025),
                                      Offset(offset, 0.0),
                                      Offset(width * 0.75 + offset, height * 0.025),
                                      Offset(width * 0.75 * 2 + offset, 0.0),
                                    ],
                                  ).addScale([0.5, 0.95, 1, 0.95, 0.5], Alignment.center),
                                  itemWidth: 300.0,
                                  itemHeight: height,
                                  itemBuilder: (context, idx) {
                                    final card = Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Card(
                                            color: Colors.black,
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/ricky.png',
                                              image: state.artists[idx].profileUrl,
                                              fit: BoxFit.cover,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            elevation: 10,
                                            margin: EdgeInsets.all(10),
                                          ),
                                        ),
                                        Text(
                                          state.artists[idx].name,
                                          style: Theme.of(context).textTheme.title,
                                        ),
                                        Text(
                                          state.artists[idx].studio.name,
                                          style: Theme.of(context).textTheme.subtitle,
                                        )
                                      ],
                                    );
                                    final well = Positioned.fill(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor: Colors.lightGreenAccent,
                                          onTap: () {
                                            final ScreenNavigator nav = sl.get<ScreenNavigator>();
                                            nav.openNewJourneyScreen(
                                                context, state.artists[idx].artistID);
                                          },
                                        ),
                                      ),
                                    );
                                    return Stack(
                                      children: <Widget>[
                                        card,
                                        well,
                                      ],
                                    );
                                  });
                            },
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ));
  }
}

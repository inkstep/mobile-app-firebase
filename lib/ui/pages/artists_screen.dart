import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/resources/artists.dart';
import 'package:inkstep/theme.dart';
import 'package:inkstep/ui/components/artist_card.dart';
import 'package:inkstep/utils/screen_navigator.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
      ),
      body: Container(
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
                        itemCount: offlineArtists.length,
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
                          final artist = offlineArtists[idx];
                          // TODO(mm): put inkwell on card not over the top of everything in stack
                          final well = Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.grey[50].withOpacity(0.2),
                                onTap: () {
                                  final ScreenNavigator nav = sl.get<ScreenNavigator>();
                                  nav.openNewJourneyScreen(context, artist.artistId);
                                },
                              ),
                            ),
                          );
                          return Stack(
                            children: <Widget>[
                              ArtistCard(artist: artist),
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
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/firestore.dart';
import 'package:inkstep/resources/artists_repository.dart';
import 'package:inkstep/resources/offline_data.dart';
import 'package:inkstep/resources/web_repository.dart';
import 'package:inkstep/theme.dart';
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
    _client = http.Client();
    // TODO: load artists
    super.initState();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  Widget _buildLoading() {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.0,
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).cardColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('artists').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return _buildLoading();
        }

        List<Artist> artists = snapshot.data.documents.map((dynamic d) => Artist.fromMap(d.data));

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
                              itemCount: artists.length,
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
                                        child: offlineArtists[0].artistImage,
                                        //  child: artists[idx].,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: smallBorderRadius,
                                        ),
                                        elevation: 10,
                                        margin: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Text(
                                      artists[idx].name,
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                    Text(
                                      'SCM',
                                      // artists[idx].studio.name,
                                      style: Theme.of(context).textTheme.subtitle,
                                    )
                                  ],
                                );
                                final well = Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: Colors.grey[50].withOpacity(0.2),
                                      onTap: () {
                                        final ScreenNavigator nav = sl.get<ScreenNavigator>();
                                        nav.openNewJourneyScreen(
                                            context, artists[idx].id);
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
            ));
      },
    );
  }
}

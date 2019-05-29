import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journey_bloc.dart';
import 'package:inkstep/models/journey_model.dart';

import '../main.dart';

class AddCard extends StatelessWidget {
  const AddCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = Theme
        .of(context)
        .backgroundColor;
    final JourneyBloc _journeyBloc = BlocProvider.of<JourneyBloc>(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme
            .of(context)
            .cardColor,
        child: InkWell(
          onTap: () {
            _journeyBloc.dispatch(JourneyEvent.add);
//            Navigator.push<dynamic>(context,
//                MaterialPageRoute<dynamic>(builder: (BuildContext context) {
//              return InfoScreen();
//            }));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 52.0,
                  color: textColor,
                ),
                Container(
                  height: 8.0,
                ),
                Text(
                  'Start a new journey',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JourneyCard extends StatelessWidget {
  final JourneyModel model;

  const JourneyCard({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JourneyBloc _journeyBlock = BlocProvider.of<JourneyBloc>(context);

    return GestureDetector(
      onTap: () {
        print('Existing card tapped');
      },
      child: BlocBuilder(
          bloc: _journeyBlock,
          builder: (BuildContext context, List<JourneyModel> journeys) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(
                      flex: 8,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 4.0),
                      // TODO: Should be Hero-d
                      child: Text(
                        '${model.artistName}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .body1
                            .copyWith(color: baseColors['gray']),
                      ),
                    ),
                    Container(
                      // TODO: Should be Hero-d
                      child: Text('${model.studioName}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .title
                              .copyWith(color: Theme
                              .of(context)
                              .accentColor)),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

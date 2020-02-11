import 'package:flutter/material.dart';
import 'package:inkstep/resources/events.dart';
import 'package:inkstep/ui/components/date_block.dart';

import '../../theme.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: offlineEvents.length,
      itemBuilder: (context, idx) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: EventCard(
            event: offlineEvents[idx],
          ),
        );
      },
    );
  }
}

class EventCard extends StatelessWidget {
  EventCard({@required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    // See also ListTile and ButtonBar
    return Card(
      color: Colors.black,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0, bottom: 24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.name,
              style: Theme.of(context).textTheme.subhead,
            ),
            Expanded(
              child: Container(height: 0),
            ),
            DateBlock(
              date: event.date,
              onlyDate: true,
              scale: 1.75,
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: smallBorderRadius,
      ),
      elevation: 10,
      margin: EdgeInsets.all(10),
    );
  }
}

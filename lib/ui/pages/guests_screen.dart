import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:inkstep/resources/guests.dart';

import 'events_screen.dart';

class GuestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: offlineGuests.length,
      itemBuilder: (context, idx) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: EventCard(
            event: offlineGuests[idx],
          ),
        );
      },
    );
  }
}

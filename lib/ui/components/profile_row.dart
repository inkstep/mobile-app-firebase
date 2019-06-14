import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  ProfileRow({
    @required this.imagePath,
    @required this.name,
    @required this.studioName,
    @required this.artistID,
    Key key,
  }) : super(key: key);

  final String imagePath;
  final String name;
  final String studioName;
  final int artistID;

  @override
  Widget build(BuildContext context) {
    final Image profileImage = Image.asset(imagePath ?? 'assets/ricky.png');
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 25.0,
            backgroundImage: profileImage.image,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: Theme.of(context)
                      .accentTextTheme
                      .subtitle
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  studioName,
                  style: Theme.of(context).accentTextTheme.body1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

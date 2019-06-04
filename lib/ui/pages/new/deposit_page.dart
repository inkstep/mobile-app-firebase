import 'package:flutter/material.dart';

class DepositPage extends StatelessWidget {

  const DepositPage({
    Key key,
    @required this.callback,
  }) : super(key: key);

  final void Function() callback;



  @override
  Widget build(BuildContext context) {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.stretch,
     children: <Widget>[
       Expanded(
           child: Text(
             'Are you willing to leave a deposit?',
             style: Theme.of(context).accentTextTheme.title,
             textAlign: TextAlign.center,
             textScaleFactor: 1.5,
           ),
           flex: 6
       ),
       Spacer(flex: 2,),
       Expanded(
           child: Text(
             'People often cancel on your artist, and they find this frustating, '
                 'so they ask for a deposit.',
             style: Theme.of(context).accentTextTheme.title,
             textAlign: TextAlign.center,
             textScaleFactor: 0.75,
           ),
           flex: 6
       ),
       Row(
         children: <Widget>[
           Spacer(flex: 2,),
           Expanded(
             child:RaisedButton(
               onPressed: callback,
               elevation: 15.0,
               padding: EdgeInsets.fromLTRB(
                   32.0, 16.0, 32.0, 16.0),
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30.0)),
               child: Text('Yes!', style: TextStyle(
                   fontSize: 20.0, fontFamily: 'Signika'),
               ),
             ),
             flex: 3,
           ),
           Spacer(flex: 2,),
         ],
       ),
       Spacer(flex: 3,),
     ],
   );
  }

}
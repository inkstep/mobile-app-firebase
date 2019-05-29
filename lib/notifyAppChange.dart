import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InkstepNotify',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.black,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String appTitle = 'InkstepNotify';
  
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar:AppBar(
        title:Text(appTitle),
      ),
      body: MessagingWidget(),
    );

}

class MessagingWidget extends StatefulWidget {
  @override
  MessagingWidgetState createState() => MessagingWidgetState();
}

class MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("OnMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(title: notification['title'],body: notification['body']));
        });
      },

      onLaunch: (Map<String, dynamic> message) async {
        print("OnLaunch: $message");

        setState(() {
          messages.add(Message(
            title: 'OnLaunch',
            body: 'OnLaunch',
          ));
        });

        final notification = message['notification'];

        setState(() {
          messages.add(Message(
            title: 'On Launch: ${notification['title']}',
            body: 'On Launch: ${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("OnResume: $message");
      }
    );
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound:true, badge:true, alert:true));
  }

  @override
  Widget build(BuildContext context) => ListView(children: messages.map(buildMessage).toList());

  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );
}


class Message {
  final String title;
  final String body;

  const Message({
    @required this.title,
    @required this.body,
  });
}
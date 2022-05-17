// ignore_for_file: avoid_print, unused_local_variable, unused_field, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/item.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.getToken().then((value) => print("Token: $value"));

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print(
          'Message also contained a notification: title ${message.notification!.title}, body ${message.notification!.title}');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Push Notification")));
  }
}

// bool _topicButtonsDisabled = false;

//   Future<dynamic> myBackgroundMessageHandler(
//       Map<String, dynamic> message) async {
//     if (message.containsKey('data')) {
//       // Handle data message
//       final dynamic data = message['data'];
//     }

//     if (message.containsKey('notification')) {
//       // Handle notification message
//       final dynamic notification = message['notification'];
//     }

//     // Or do other work.
//   }

//   final Map<String, Item> _items = <String, Item>{};
//   Item _itemForMessage(Map<String, dynamic> message) {
//     final dynamic data = message['data'] ?? message;
//     final String itemId = data['id'];
//     final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId));
//     item.setMatchteam = data['matchteam'];
//     item.setScore = data['score'];
//     return item;
//   }

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final TextEditingController _topicController =
//       TextEditingController(text: 'topic');

//   Widget _buildDialog(BuildContext context, Item item) {
//     return AlertDialog(
//       content: Text("${item.matchteam} with score: ${item.score}"),
//       actions: <Widget>[
//         ElevatedButton(
//           child: const Text('CLOSE'),
//           onPressed: () {
//             Navigator.pop(context, false);
//           },
//         ),
//         ElevatedButton(
//           child: const Text('SHOW'),
//           onPressed: () {
//             Navigator.pop(context, true);
//           },
//         ),
//       ],
//     );
//   }

//   void _showItemDialog(Map<String, dynamic> message) {
//     showDialog<bool>(
//       context: context,
//       builder: (_) => _buildDialog(context, _itemForMessage(message)),
//     ).then((shouldNavigate) {
//       if (shouldNavigate == true) {
//         _navigateToItemDetail(message);
//       }
//     });
//   }

//   void _navigateToItemDetail(Map<String, dynamic> message) {
//     final Item item = _itemForMessage(message);
//     // Clear away dialogs
//     Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
//     if (!item.route.isCurrent) {
//       Navigator.push(context, item.route);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Flutter FCM'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(20.0),
//           child: Card(
//             child: Container(
//                 padding: EdgeInsets.all(10.0),
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                       child: Column(
//                         children: <Widget>[
//                           Text('Welcome to this Flutter App:',
//                               style: TextStyle(
//                                   color: Colors.black.withOpacity(0.8))),
//                           Text('You already subscribe to the matchscore topic',
//                               style: Theme.of(context).textTheme.titleMedium)
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                               'Now you will receive the push notification from the matchscore topics',
//                               style: TextStyle(
//                                   color: Colors.black.withOpacity(0.8)))
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         ),
//       ),
//     );
//   }

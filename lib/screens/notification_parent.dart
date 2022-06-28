import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:test/screens/local_notifications.dart';
import 'package:test/screens/location.dart';

import '../utils/color_utils.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(NotificationP());
}

class NotificationP extends StatelessWidget {
  static const MaterialColor blue2 = MaterialColor(
    0xFF509A77,
    <int, Color>{
      50: Color(0xFFE1FCEF),
      100: Color(0xFFBCFDDF),
      200: Color(0xFF8EFAC7),
      300: Color(0xFF63F6B1),
      400: Color(0xFF42F5A0),
      500: Color(0xFF509A77),
      600: Color(0xFF1DE586),
      700: Color(0xFF18D079),
      800: Color(0xFF14BD6D),
      900: Color(0xFF0CA05A),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late TextEditingController _textToken;
  late TextEditingController _textSetToken;
  late TextEditingController _textTitle;
  late TextEditingController _textBody;

  @override
  void dispose() {
    _textToken.dispose();
    _textTitle.dispose();
    _textBody.dispose();
    _textSetToken.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();

    _textToken = TextEditingController();
    _textSetToken = TextEditingController();
    _textTitle = TextEditingController();
    _textBody = TextEditingController();
    print("shaimaa");
    token_firebase();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                  color: Color.fromARGB(179, 255, 255, 255),
                  fontSize: 24.0,
                ),
                controller: _textBody,
                decoration: InputDecoration(labelText: "Enter your message"),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (check()) {
                          token_read();
                        }
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Color.fromARGB(179, 255, 255, 255),
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            tooltip: 'Push Notifications',
            child: Icon(Icons.directions),
          )
        ],
      ),
    );
  }

  Future<bool> pushNotificationsSpecificDevice({
    required String token,
    required String title,
    required String body,
  }) async {
    print(token);
    String dataNotifications = '{ "to" : "$token",'
        ' "notification" : {'
        ' "title":"Don’t worry i’m here",'
        '"body":"$body"'
        ' }'
        ' }';

    await http.post(
      Uri.parse(Constants.BASE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key= ${Constants.KEY_SERVER}',
      },
      body: dataNotifications,
    );
    return true;
  }

  Future<String> token() async {
    return await FirebaseMessaging.instance.getToken() ?? "";
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  bool check() {
    if (_textBody.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  // ignore: non_constant_identifier_names
  Future<void> token_firebase() async {
    _textToken.text = await token();
    print(_textToken.text);
    await FirebaseFirestore.instance
        .collection('TokenParent')
        .doc('user1')
        .set({'Tokenparent': _textToken.text}, SetOptions(merge: true));
  }

  Future<void> token_read() async {
    String _message = '';
    FirebaseFirestore.instance
        .collection("Token_child")
        .doc('user1')
        .get()
        .then((value) {
      setState(() {
        _message = value.data()!['TokenChild'];
        pushNotificationsSpecificDevice(
          title: _textTitle.text,
          body: _textBody.text,
          token: _message,
        );
      });
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

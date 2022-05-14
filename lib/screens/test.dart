import 'package:test/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:test/screens/notification_setting.dart';

class ParentOrChiled extends StatefulWidget {
  const ParentOrChiled({Key? key}) : super(key: key);

  @override
  _ParentOrChiledState createState() => _ParentOrChiledState();
}

class _ParentOrChiledState extends State<ParentOrChiled> {
  final notifications = [
    NotificationSetting(title: 'parent'),
    NotificationSetting(title: 'child'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Protect My Family",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
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
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const Text(
                    "By using this application. you will feel comfortable because your family members will be safe.",
                    style: TextStyle(
                      color: Color.fromARGB(179, 242, 241, 245),
                      fontSize: 20.0,
                    )),
                const Divider(),
                const Text("Please chose one of the following",
                    style: TextStyle(
                      color: Color.fromARGB(179, 11, 11, 11),
                      fontSize: 20.0,
                    )),
                const SizedBox(
                  height: 20,
                ),
                ...notifications.map(buildSingleCheckbox).toList(),
              ],
            ),
          ))),
    );
  }

  Widget buildSingleCheckbox(NotificationSetting notification) => buildCheckbox(
        notification: notification,
        onClicked: () {
          setState(() {
            final newValue = !notification.value;
            notification.value = newValue;
            // print(newValue);
          });
        },
      );
  Widget buildCheckbox({
    required NotificationSetting notification,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        onTap: onClicked,
        leading: Checkbox(
          value: notification.value,
          onChanged: (value) => onClicked(),
        ),
        title: Text(
          notification.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
}

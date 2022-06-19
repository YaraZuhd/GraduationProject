import 'package:test/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:test/screens/notification_setting.dart';
import 'package:test/screens/signin_screen.dart';
import 'package:test/screens/signup_child_screen.dart';
import 'package:test/utils/color_utils.dart';

class ParentOrChiled extends StatefulWidget {
  const ParentOrChiled({Key? key}) : super(key: key);

  @override
  _ParentOrChiledState createState() => _ParentOrChiledState();
}

class _ParentOrChiledState extends State<ParentOrChiled> {
  final allowNotifications = NotificationSetting(title: 'Parent device');

  final notifications = NotificationSetting(title: 'Child device');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: const Text(
      //     "Protect My Family",
      //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //   ),
      // ),
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
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                Positioned(
                  child: Image.asset(
                    "assets/images/logo1.png",
                    height: size.height * 0.35,
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                    "Please chose which device you want to use the app on",
                    style: TextStyle(
                      color: Color.fromARGB(179, 255, 255, 255),
                      fontSize: 24.0,
                    )),
                const SizedBox(
                  height: 20,
                ),
                buildToggleCheckbox(allowNotifications),
                buildSingleCheckbox(notifications),
                // ...notifications(buildSingleCheckbox).toList(),
                const SizedBox(
                  height: 20,
                ),
                signUpOption()
              ],
            ),
          ))),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("You must choose device."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget signUpOption() {
    return Column(
      children: [
        firebaseUIButton(context, "Get Start", () {
          if (allowNotifications.value) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          } else if (notifications.value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignUpchildScreen()));
          } else {
            showAlertDialog(context);
          }
        })
      ],
    );
  }

  Widget buildToggleCheckbox(NotificationSetting notification) => buildCheckbox(
      notification: notification,
      onClicked: () {
        final newValue = !notification.value;

        setState(() {
          allowNotifications.value = newValue;

          notifications.value = !newValue;
        });
      });

  Widget buildSingleCheckbox(NotificationSetting notification) => buildCheckbox(
        notification: notification,
        onClicked: () {
          setState(() {
            final newValue = !notification.value;
            notification.value = newValue;

            if (!newValue) {
              allowNotifications.value = false;
            } else {
              final allow = notifications.value;
              allowNotifications.value = !allow;
            }
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

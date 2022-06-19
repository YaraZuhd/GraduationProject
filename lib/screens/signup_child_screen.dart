import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/reusable_widgets/reusable_widget.dart';
import 'package:test/screens/nav.dart';
import 'package:test/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:test/screens/help_button.dart';

class SignUpchildScreen extends StatefulWidget {
  const SignUpchildScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpchildScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
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
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text("Please enter the code, it's in your parent's app",
                    style: TextStyle(
                      color: Color.fromARGB(179, 255, 255, 255),
                      fontSize: 24.0,
                    )),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter the code ", Icons.lock_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => help_buttonScreen()));
                })
              ],
            ),
          ))),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("You must enter all information."),
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
}

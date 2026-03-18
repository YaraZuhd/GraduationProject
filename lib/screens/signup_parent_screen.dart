import 'package:firebase_auth/firebase_auth.dart';
import 'package:protect_my_kids/data/data_model.dart';
import 'package:protect_my_kids/reusable_widgets/reusable_widget.dart';
import 'package:protect_my_kids/screens/signin_screen.dart';
import 'package:protect_my_kids/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:protect_my_kids/data/data_repositry.dart';

class SignUpParentScreen extends StatefulWidget {
  const SignUpParentScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpParentScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final DataRepository repository = DataRepository();

  String? _validateInputs() {
    final username = _userNameTextController.text.trim();
    final email = _emailTextController.text.trim();
    final password = _passwordTextController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      return "Please fill in all fields.";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return "Please enter a valid email address.";
    }
    if (password.length < 6) {
      return "Password must be at least 6 characters.";
    }
    return null;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

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
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                reusableTextField("Enter Username", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(height: 20),
                reusableTextField("Enter Email", Icons.email_outlined, false,
                    _emailTextController),
                const SizedBox(height: 20),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(height: 20),
                firebaseUIButton(context, "Sign Up", () {
                  final error = _validateInputs();
                  if (error != null) {
                    _showErrorDialog(error);
                    return;
                  }
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text.trim(),
                          password: _passwordTextController.text)
                      .then((value) {
                    repository.addDataModel(DataModel(
                        _userNameTextController.text.trim(),
                        _emailTextController.text.trim(),
                        _passwordTextController.text,
                        '',
                        '',
                        ''));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                  }).onError((error, stackTrace) {
                    String message = "Sign up failed. Please try again.";
                    if (error is FirebaseAuthException) {
                      if (error.code == 'email-already-in-use') {
                        message = "An account already exists for this email.";
                      } else if (error.code == 'weak-password') {
                        message = "The password is too weak.";
                      } else if (error.code == 'invalid-email') {
                        message = "The email address is not valid.";
                      }
                    }
                    _showErrorDialog(message);
                  });
                })
              ],
            ),
          ))),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/reusable_widgets/reusable_widget.dart';
import 'package:test/screens/add_favorite.dart';
import 'package:test/screens/nav.dart';
import 'package:test/screens/settings.dart';
import 'package:test/utils/color_utils.dart';

class AddKid extends StatefulWidget {
  const AddKid({Key? key}) : super(key: key);

  @override
  State<AddKid> createState() => _AddKidState();
}

class _AddKidState extends State<AddKid> {
  int _selectedIndex = 0;
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _nameTextController = TextEditingController();
  // final TextEditingController _dobTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: '',
                          )));
            },
          ),
          title: const Text('Add Kid To Protect'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                  hexStringToColor("CB2B93"),
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4")
                ])),
          )),
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
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Please Fill The Following Information To Generate A Code To Conect Your Kid Device',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Enter Kid Name", Icons.person, false, _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                // reusableTextField("Enter  ", Icons.person_outline, false,
                //     _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                // firebaseUIButton(context, "Sign Up", () {
                //   FirebaseAuth.instance
                //       .createUserWithEmailAndPassword(
                //           email: _emailTextController.text,
                //           password: _passwordTextController.text)
                //       .then((value) {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const HomeScreen()));
                //   }).onError((error, stackTrace) {
                //     // print("Error ${error.toString()}");
                //   });
                // })
              ],
            ),
          ))),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/screens/info_card.dart';

// our data
//const email = "nnaderz@outlook.com";
//const password = "123123"; // not real number 🙂
//const childDateOB = "2003-04-27";
//const Kidname = "Mohammad";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: Profilescreen()));
}

/*class Profilescreen extends StatefulWidget{
  @override
  State<Profilescreen> createState() => _profileScreenState();

}*/

class Profilescreen extends StatefulWidget {
  const Profilescreen({Key? key}) : super(key: key);

  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<Profilescreen> {
  String? name = ' ';
  String? email = ' ';
  String? dateofbirth = ' ';
  String? username = ' ';
  String? password = ' ';

  Future _getDataFromDatebase() async {
    print("linaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    await FirebaseFirestore.instance
        .collection("DataModel")
        .doc('CqptbDbbc9g6BOyohS3h')
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["KidName"];
          email = snapshot.data()!["email"];
          dateofbirth = snapshot.data()!["childDateOB"];
          username = snapshot.data()!["username"];
          password = snapshot.data()!["password"];
          print("shaimaaaaaaaaaaaaaaaaaaaaaaaaa");
          print(name);
        });
      }
    });
  }

  @override
  void instance() {
    super.initState();
    _getDataFromDatebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 166, 100, 178),
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 166, 100, 178),
                radius: 50,
                backgroundImage: AssetImage("assets/images/logo1.png"),
              ),

              Text(
                ' ' + username!,
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),

              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              // we will be creating a new widget name info carrd
              InfoCard(
                  text: ' ' + email!,
                  icon: Icons.email,
                  onPressed: () async {}),
              InfoCard(
                  text: ' ' + password!,
                  icon: Icons.lock,
                  onPressed: () async {}),
              const Divider(
                thickness: 2,
              ),
              const Text("child information",
                  style: TextStyle(
                    color: Color.fromARGB(179, 255, 255, 255),
                    fontSize: 18.0,
                  )),
              InfoCard(
                  text: ' ' + name!,
                  icon: Icons.person,
                  onPressed: () async {}),
              InfoCard(
                  text: ' ' + dateofbirth!,
                  icon: Icons.date_range,
                  onPressed: () async {}),
            ],
          ),
        ));
  }
}

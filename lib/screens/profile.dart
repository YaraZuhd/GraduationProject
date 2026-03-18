import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:protect_my_kids/screens/info_card.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({Key? key}) : super(key: key);

  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<Profilescreen> {
  String? name = '';
  String? email = '';
  String? dateofbirth = '';
  String? username = '';

  Future<void> _getDataFromDatabase() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    await FirebaseFirestore.instance
        .collection("DataModel")
        .where('email', isEqualTo: currentUser.email)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        setState(() {
          name = data['kidName'] ?? '';
          email = data['email'] ?? '';
          dateofbirth = data['childDateOB'] ?? '';
          username = data['username'] ?? '';
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
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
                ' ${username ?? ''}',
                style: const TextStyle(
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
              InfoCard(
                  text: ' ${email ?? ''}',
                  icon: Icons.email,
                  onPressed: () async {}),
              const Divider(
                thickness: 2,
              ),
              const Text("Child Information",
                  style: TextStyle(
                    color: Color.fromARGB(179, 255, 255, 255),
                    fontSize: 18.0,
                  )),
              InfoCard(
                  text: ' ${name ?? ''}',
                  icon: Icons.person,
                  onPressed: () async {}),
              InfoCard(
                  text: ' ${dateofbirth ?? ''}',
                  icon: Icons.date_range,
                  onPressed: () async {}),
            ],
          ),
        ));
  }
}

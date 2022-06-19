import 'package:flutter/material.dart';
import 'package:test/screens/info_card.dart';

// our data
const email = "nnaderz@outlook.com";
const password = "123123"; // not real number :)
const childDateOB = "2003-04-27";
const Kidname = "Mohammad";

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 166, 100, 178),
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 166, 100, 178),
                radius: 50,
                backgroundImage: AssetImage("assets/images/logo1.png"),
              ),
              Text(
                "NaderZ",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),

              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              // we will be creating a new widget name info carrd
              InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
              InfoCard(
                  text: password, icon: Icons.lock, onPressed: () async {}),
              Divider(
                thickness: 2,
              ),
              const Text("child information",
                  style: TextStyle(
                    color: Color.fromARGB(179, 255, 255, 255),
                    fontSize: 18.0,
                  )),
              InfoCard(
                  text: Kidname, icon: Icons.person, onPressed: () async {}),
              InfoCard(
                  text: childDateOB,
                  icon: Icons.date_range,
                  onPressed: () async {}),
            ],
          ),
        ));
  }
}

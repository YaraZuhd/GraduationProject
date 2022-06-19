import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: const Color.fromARGB(255, 166, 100, 178),
          ),
          title: Text(
            text,
            style: TextStyle(
                color: const Color.fromARGB(255, 166, 100, 178),
                fontSize: 18,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}

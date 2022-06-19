import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/reusable_widgets/reusable_widget.dart';
import 'package:test/screens/add_favorite.dart';
import 'package:test/screens/home_screen.dart';
import 'package:test/screens/settings.dart';
import 'package:test/utils/color_utils.dart';
import 'package:test/data/data_model.dart';
import 'package:test/data/data_repositry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddKid extends StatefulWidget {
  const AddKid({Key? key}) : super(key: key);

  @override
  State<AddKid> createState() => _AddKidState();
}

class _AddKidState extends State<AddKid> {
  int _selectedIndex = 0;
  String exsistingCode = '';
  late String docId;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? email = FirebaseAuth.instance.currentUser!.email;
  List emailcode = [];
  late String code;
  late DataModel data;
  final DataRepository rep = DataRepository();
  DateTime selectedDate = DateTime.now();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _dobTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          title: const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: Text('Add Kid To Protect'),
          ),
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
      bottomNavigationBar: BottomNavigationBar(
        mouseCursor: SystemMouseCursors.grab,
        iconSize: 20,
        selectedFontSize: 14,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Kid',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gps_fixed),
            label: 'Tracking Kid',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 149, 71, 163),
        onTap: _onItemTapped,
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
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Please Fill The Following Information \nTo Generate A Code and Conect \nYour Kid Device',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'PlayfairDisplay'),
                ),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField(
                    "Enter Kid Name", Icons.person, false, _nameTextController),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _dobTextController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.edit_calendar_rounded,
                      color: Colors.white70,
                    ),
                    labelText: 'Enter Date of birth',
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                  focusNode: AlwaysDisabledFocusNode(),
                  keyboardType: TextInputType.datetime,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(500, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      primary: const Color.fromARGB(255, 246, 244, 244),
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 0)),
                  onPressed: validateInfo()
                      ? () {
                          FirebaseFirestore.instance
                              .collection('DataModel')
                              .where('email', isEqualTo: email)
                              .get()
                              .then((value) {
                            for (var element in value.docs) {
                              docId = element.id;
                              //print(element.id);
                            }
                          });
                          FirebaseFirestore.instance
                              .collection('DataModel')
                              .doc(docId)
                              .get()
                              .then((value) {
                            exsistingCode = value.get('uniqueCode');
                            //print('12');
                          });
                          //print(exsistingCode);
                          if (exsistingCode == '') {
                            code = generateRandomString();
                            _showDialog(context);
                            FirebaseFirestore.instance
                                .collection('DataModel')
                                .where('email', isEqualTo: email)
                                .get()
                                .then((snapshot) {
                              for (var doc in snapshot.docs) {
                                doc.reference.update({
                                  'childDateOB': _dobTextController.text,
                                  'kidName': _nameTextController.text,
                                  'uniqueCode': code,
                                });
                              }
                            });
                          } else {
                            code = exsistingCode;
                            _showDialog(context);
                          }
                        }
                      : null,
                  child: const Text(
                    'Generate Code',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ))),
    );
  }

  bool validateInfo() {
    if (_nameTextController.text == '' || _dobTextController.text == '') {
      return false;
    } else {
      return true;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddKid()));
      } else if (index == 1) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddFavorite()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AppSettings()));
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String convertedDateTime =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        _dobTextController.value = TextEditingValue(text: convertedDateTime);
      });
    }
  }

  String generateRandomString() {
    int len = 6;
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  _showDialog(BuildContext context) {
    showDialog(
        builder: (context) => CupertinoAlertDialog(
              title: Column(
                children: const <Widget>[
                  Text("Connection Code"),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
              content: Text(code,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                // CupertinoDialogAction(
                //   child: Text("CANCEL"),
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },),
                // CupertinoDialogAction(
                //   child: Text("MAY BE"),
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },),
              ],
            ),
        context: context);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class EmailsAndCodes {
  String email;
  String uniqueID;

  EmailsAndCodes(this.email, this.uniqueID);

  @override
  String toString() {
    return '{ $email, $uniqueID }';
  }
}

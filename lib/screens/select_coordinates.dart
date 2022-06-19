import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/data/data_repositry_areas.dart';
import 'package:test/data/red_and_green.dart';
import 'package:test/reusable_widgets/reusable_widget.dart';
import 'package:test/screens/nav.dart';
import 'package:test/screens/view_areas.dart';
import 'package:test/utils/color_utils.dart';

class SelectCoordinates extends StatefulWidget {
  const SelectCoordinates({Key? key}) : super(key: key);

  @override
  State<SelectCoordinates> createState() => _SelectCoordinatesState();
}

class _SelectCoordinatesState extends State<SelectCoordinates> {
  final TextEditingController _langController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  List<RedAndGreen> data = [];
  final DataRepositoryAreas repository = DataRepositoryAreas();
  int val = -1;
  bool safe = false;
  bool nsafe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
            child: Text('Select Coordinates'),
          ),
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
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Please Fill The Information Below:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'PlayfairDisplay'),
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Enter latitude", Icons.location_on, false, _latController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter longitude ", Icons.location_on, false,
                    _langController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Area Name ", Icons.location_city,
                    false, _areaController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Enter Email ", Icons.email, false, _emailController),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Please Chose One Of The Following :',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'PlayfairDisplay'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      title: const Text(
                        "Safe",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'PlayfairDisplay'),
                      ),
                      leading: Radio(
                        value: 1,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value as int;
                          });
                        },
                        activeColor: Colors.purple[200],
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Not Safe",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'PlayfairDisplay'),
                      ),
                      leading: Radio(
                        value: 2,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value as int;
                          });
                        },
                        activeColor: Colors.purple[200],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                              _showDialog(context);
                              if (val == 1) {
                                safe = true;
                              } else {
                                nsafe = true;
                              }
                              data.add(RedAndGreen(
                                  _emailController.text,
                                  _langController.text,
                                  _latController.text,
                                  _areaController.text,
                                  safe,
                                  nsafe));
                              //print(data);
                              repository.addRedAndGreen(data[0]);
                              data = [];
                              _emailController.text = '';
                              _langController.text = '';
                              _latController.text = '';
                              _areaController.text = '';
                              val = -1;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ViewAreas(),
                                ),
                              );
                            }
                          : null,
                      child: const Text(
                        'Insert Data',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ))),
    );
  }

  bool validateInfo() {
    if (_latController.text == '' ||
        _langController.text == '' ||
        _areaController.text == '' ||
        _emailController.text == '' ||
        val == -1) {
      return false;
    } else {
      return true;
    }
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
              content:
                  const Text('The Information Has Been Added Successfully ',
                      style: TextStyle(
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
              ],
            ),
        context: context);
  }
}

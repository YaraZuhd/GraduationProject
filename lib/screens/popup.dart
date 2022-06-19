import 'package:flutter/material.dart';
import 'package:test/data/data_repositry_areas.dart';
import 'package:test/data/red_and_green.dart';
import 'package:test/reusable_widgets/reusable_widget.dart';
import 'package:test/screens/home_screen.dart';
import 'package:test/screens/view_areas.dart';
import 'package:test/utils/color_utils.dart';

class PopUpScreen extends StatelessWidget {
  final double? lat;
  final double? long;
  PopUpScreen(this.lat, this.long, {Key? key}) : super(key: key);
  final TextEditingController _areaController = TextEditingController();
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
            child: Text('Select From Map'),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                  'Please Fill The Rest Information Below:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'PlayfairDisplay'),
                ),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(500, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      primary: const Color.fromARGB(255, 246, 244, 244),
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 0)),
                  onPressed: validateInfo()
                      ? () => {
                            //print(lat),
                            data.add(RedAndGreen(
                                _emailController.text,
                                long.toString(),
                                lat.toString(),
                                _areaController.text,
                                true,
                                false)),
                            //print(data),
                            repository.addRedAndGreen(data[0]),
                            data = [],
                            _emailController.text = '',
                            _areaController.text = '',
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ViewAreas(),
                              ),
                            ),
                          }
                      : null,
                  child: const Text(
                    'Safe',
                    style: TextStyle(color: Colors.black),
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
                      ? () => {
                            data.add(RedAndGreen(
                                _emailController.text,
                                long.toString(),
                                lat.toString(),
                                _areaController.text,
                                false,
                                true)),
                            //print(data),
                            repository.addRedAndGreen(data[0]),
                            data = [],
                            _emailController.text = '',
                            _areaController.text = '',
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ViewAreas(),
                              ),
                            ),
                          }
                      : null,
                  child: const Text(
                    'Not Safe',
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
    if (_areaController.text == '' || _emailController.text == '') {
      return false;
    } else {
      return true;
    }
  }
}

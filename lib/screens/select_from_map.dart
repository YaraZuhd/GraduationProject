import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/screens/nav.dart';
import 'package:test/screens/popup.dart';
import 'package:test/utils/color_utils.dart';

class SelectFromMap extends StatefulWidget {
  const SelectFromMap({Key? key}) : super(key: key);

  @override
  State<SelectFromMap> createState() => _SelectFromMapState();
}

class _SelectFromMapState extends State<SelectFromMap> {
  final Completer<GoogleMapController> _controller = Completer();
  late double lat;
  late double long;
  //String _address = ""; // create this variable
  static const CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(31.768319, 35.21371),
    //LatLng(32.0884848, 35.1768524),
    zoom: 14.987,
  );

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
      body: GoogleMap(
        //mapType: MapType.hybrid,
        initialCameraPosition: _initalCameraPosition,
        // CameraPosition(
        //     target: LatLng(double.parse(lat), double.parse(long)), zoom: 14.87),
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (latLng) {
          //print('${latLng.latitude}, ${latLng.longitude}');
          lat = latLng.latitude;
          long = latLng.longitude;
          //_showDialog(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PopUpScreen(lat, long),
            ),
          );
        },
      ),
    );
  }

  // _showDialog(BuildContext context) {
  //   showDialog(
  //       builder: (context) => CupertinoAlertDialog(
  //             title: Column(
  //               children: const <Widget>[
  //                 Text("The Selected Coordinate :\n"),
  //                 SizedBox(
  //                   height: 20,
  //                 )
  //               ],
  //             ),
  //             content: Text(
  //                 'Lat : ' + lat.toString() + '\nLong : ' + long.toString(),
  //                 style: const TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 20,
  //                 )),
  //             actions: <Widget>[
  //               CupertinoDialogAction(
  //                 child: const Text("OK"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //       context: context);
  // }
}

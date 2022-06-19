import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/data/data_repositry_areas.dart';
import 'package:test/data/red_and_green.dart';
import 'package:test/screens/add_favorite.dart';
import 'package:test/screens/areas_card.dart';
import 'package:test/screens/home_screen.dart';
import 'package:test/utils/color_utils.dart';

class ViewAreas extends StatefulWidget {
  const ViewAreas({Key? key}) : super(key: key);

  @override
  State<ViewAreas> createState() => _ViewAreasState();
}

class _ViewAreasState extends State<ViewAreas> {
  final DataRepositoryAreas repository = DataRepositoryAreas();
  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
            child: Text('View Red And Green Areas'),
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
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();

            return _buildList(context, snapshot.data?.docs ?? []);
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[200],
        onPressed: () {
          _addNewArea();
        },
        tooltip: 'Add New Area',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addNewArea() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddFavorite()));
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final data = RedAndGreen.fromSnapshot(snapshot);

    return AreasCard(data: data, boldStyle: boldStyle);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Locations {
  String lang;
  String lat;
  String areaName;
  String email;

  String? referenceId;

  Locations(this.email, this.lang, this.lat, this.areaName, {this.referenceId});
  factory Locations.fromJson(Map<String, dynamic> json) {
    return _locationsFromJson(json);
  }

  factory Locations.fromSnapshot(DocumentSnapshot snapshot) {
    final newdata = Locations.fromJson(snapshot.data() as Map<String, dynamic>);
    newdata.referenceId = snapshot.reference.id;
    return newdata;
  }

  Map<String, dynamic> toJson() => _locationsToJson(this);

  @override
  String toString() {
    return '{ $email ,$lang , $lat, $areaName}';
  }
}

// 1
Locations _locationsFromJson(Map<String, dynamic> json) {
  return Locations(
    json['email'] as String,
    json['lang'] as String,
    json['lat'] as String,
    json['areaName'] as String,
  );
}

Map<String, dynamic> _locationsToJson(Locations instance) => <String, dynamic>{
      'email': instance.email,
      'lang': instance.lang,
      'lat': instance.lat,
      'areaName': instance.areaName,
    };

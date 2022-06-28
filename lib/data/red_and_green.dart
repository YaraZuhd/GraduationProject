import 'package:cloud_firestore/cloud_firestore.dart';

class RedAndGreen {
  String lang;
  String lat;
  String areaName;
  String email;
  bool safe;
  bool notSafe;
  String? referenceId;

  RedAndGreen(
      this.email, this.lang, this.lat, this.areaName, this.safe, this.notSafe,
      {this.referenceId});
  factory RedAndGreen.fromJson(Map<String, dynamic> json) {
    return _redAndGreenFromJson(json);
  }

  factory RedAndGreen.fromSnapshot(DocumentSnapshot snapshot) {
    final newdata =
        RedAndGreen.fromJson(snapshot.data() as Map<String, dynamic>);
    newdata.referenceId = snapshot.reference.id;
    return newdata;
  }

  Map<String, dynamic> toJson() => _redAndGreenToJson(this);

  @override
  String toString() {
    return '{ $email ,$lang , $lat, $areaName ,$safe, $notSafe}';
  }
}

// 1
RedAndGreen _redAndGreenFromJson(Map<String, dynamic> json) {
  return RedAndGreen(
    json['email'] as String,
    json['lang'] as String,
    json['lat'] as String,
    json['areaName'] as String,
    json['safe'] as bool,
    json['notSafe'] as bool,
  );
}

Map<String, dynamic> _redAndGreenToJson(RedAndGreen instance) =>
    <String, dynamic>{
      'email': instance.email,
      'lang': instance.lang,
      'lat': instance.lat,
      'areaName': instance.areaName,
      'safe': instance.safe,
      'notSafe': instance.notSafe,
    };

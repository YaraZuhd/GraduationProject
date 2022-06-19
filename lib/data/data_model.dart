import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  String email;
  String password;
  String username;
  String uniqueCode;
  String childDateOB;
  String kidName;
  String? referenceId;

  DataModel(this.username, this.email, this.password, this.childDateOB,
      this.uniqueCode, this.kidName,
      {this.referenceId});
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return _dataModelFromJson(json);
  }

  set childName(String name) {
    kidName = name;
  }

  set childDOB(String date) {
    childDateOB = date;
  }

  set childCode(String code) {
    uniqueCode = code;
  }

  factory DataModel.fromSnapshot(DocumentSnapshot snapshot) {
    final newdata = DataModel.fromJson(snapshot.data() as Map<String, dynamic>);
    newdata.referenceId = snapshot.reference.id;
    return newdata;
  }

  Map<String, dynamic> toJson() => _dataModelToJson(this);

  @override
  String toString() {
    return '{ $username , $email, $password , $childDateOB,$kidName,$uniqueCode}';
  }
}

// 1
DataModel _dataModelFromJson(Map<String, dynamic> json) {
  return DataModel(
    json['email'] as String,
    json['password'] as String,
    json['username'] as String,
    json['uniqueCode'] as String,
    json['childDateOB'] as String,
    json['kidName'] as String,
  );
}

Map<String, dynamic> _dataModelToJson(DataModel instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'uniqueCode': instance.uniqueCode,
      'childDateOB': instance.childDateOB,
      'kidName': instance.kidName,
    };

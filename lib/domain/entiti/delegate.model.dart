// To parse this JSON data, do
//
//     final delegateModel = delegateModelFromJson(jsonString);

import 'dart:convert';

DelegateModel delegateModelFromJson(String str) =>
    DelegateModel.fromJson(json.decode(str) as Map<String, dynamic>);

String delegateModelToJson(DelegateModel data) => json.encode(data.toJson());

class DelegateModel {

  DelegateModel({
    required this.delegateId,
    required this.studentname,
    required this.studentci,
    required this.studentfrontname,
    required this.pollingtablenumber,
    required this.pollingtableid,
    required this.signature,
  });

  factory DelegateModel.fromJson(Map<String, dynamic> json) => DelegateModel(
      delegateId: json['delegate_id'] as String,
      studentname: json['studentname'] as String,
      studentci: json['studentci'] as String,
      studentfrontname: json['studentfrontname'] as String,
      pollingtablenumber: json['pollingtablenumber'] as int,
      pollingtableid: json['pollingtableid'] as String,
      signature: json['signature'] as String,
  );
  final String delegateId;
  final String studentname;
  final String studentci;
  final String studentfrontname;
  final int pollingtablenumber;
  final String pollingtableid;
  final String signature;

  Map<String, dynamic> toJson() => {
        'delegate_id': delegateId,
        'studentname': studentname,
        'studentci': studentci,
        'studentfrontname': studentfrontname,
        'pollingtablenumber': pollingtablenumber,
        'pollingtableid': pollingtableid,
        'signature': signature,
      };
}

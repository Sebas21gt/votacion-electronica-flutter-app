// To parse this JSON data, do
//
//     final resultsModel = resultsModelFromJson(jsonString);

import 'dart:convert';

ResultsModel resultsModelFromJson(String str) =>
    ResultsModel.fromJson(json.decode(str) as Map<String, dynamic>);

String resultsModelToJson(ResultsModel data) => json.encode(data.toJson());

class ResultsModel {

  ResultsModel({
    required this.id,
    required this.votes,
    required this.studentFront,
  });

  factory ResultsModel.fromJson(Map<String, dynamic> json) => ResultsModel(
        id: json['id'] as String,
        votes: json['votes'] as int,
        studentFront:
            StudentFront.fromJson(json['studentFront'] as Map<String, dynamic>),
      );
  final String id;
  final int votes;
  final StudentFront studentFront;

  Map<String, dynamic> toJson() => {
        'id': id,
        'votes': votes,
        'studentFront': studentFront.toJson(),
      };
}

class StudentFront {

  StudentFront({
    required this.name,
    required this.logo,
  });

  factory StudentFront.fromJson(Map<String, dynamic> json) => StudentFront(
        name: json['name'] as String,
        logo: json['logo'] as String,
      );
  final String name;
  final String logo;

  Map<String, dynamic> toJson() => {
        'name': name,
        'logo': logo,
      };
}

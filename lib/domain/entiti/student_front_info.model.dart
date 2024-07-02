// To parse this JSON data, do
//
//     final studentFrontInfoModel = studentFrontInfoModelFromJson(jsonString);

// ignore_for_file: avoid_dynamic_calls, lines_longer_than_80_chars

import 'dart:convert';

StudentFrontInfoModel studentFrontInfoModelFromJson(String str) =>
    StudentFrontInfoModel.fromJson(json.decode(str) as Map<String, dynamic>);

String studentFrontInfoModelToJson(StudentFrontInfoModel data) =>
    json.encode(data.toJson());

class StudentFrontInfoModel {
  StudentFrontInfoModel({
    required this.studentFront,
    required this.proposals,
    required this.positions,
  });

  factory StudentFrontInfoModel.fromJson(Map<String, dynamic> json) =>
      StudentFrontInfoModel(
        studentFront:
            StudentFront.fromJson(json['studentFront'] as Map<String, dynamic>),
        proposals: List<Proposal>.from(
          json['proposals'].map(Proposal.fromJson) as Iterable<dynamic>,
        ),
        positions: List<Position>.from(
          json['positions'].map(Position.fromJson) as Iterable<dynamic>,
        ),
      );
  final StudentFront studentFront;
  final List<Proposal> proposals;
  final List<Position> positions;

  Map<String, dynamic> toJson() => {
        'studentFront': studentFront.toJson(),
        'proposals': List<dynamic>.from(proposals.map((x) => x.toJson())),
        'positions': List<dynamic>.from(positions.map((x) => x.toJson())),
      };
}

class Position {
  Position({
    required this.studentName,
    required this.studentCi,
    required this.positionName,
    required this.positionDescription,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        studentName: json['studentName'] as String,
        studentCi: json['studentCI'] as String,
        positionName: json['positionName'] as String,
        positionDescription: json['positionDescription'] as String,
      );
  final String studentName;
  final String studentCi;
  final String positionName;
  final String positionDescription;

  Map<String, dynamic> toJson() => {
        'studentName': studentName,
        'studentCI': studentCi,
        'positionName': positionName,
        'positionDescription': positionDescription,
      };
}

class Proposal {
  Proposal({
    required this.description,
    required this.proposalId,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        description: json['description'] as String,
        proposalId: json['proposalId'] as String,
      );
  final String description;
  final String proposalId;

  Map<String, dynamic> toJson() => {
        'description': description,
        'proposalId': proposalId,
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

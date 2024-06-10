import 'dart:convert';

StudentFrontModel studentFrontModelFromJson(String str) =>
    StudentFrontModel.fromJson(json.decode(str) as Map<String, dynamic>);

String studentFrontModelToJson(StudentFrontModel data) =>
    json.encode(data.toJson());

class StudentFrontModel {

  StudentFrontModel({
    required this.id,
    required this.status,
    required this.name,
    required this.acronym,
    required this.logo,
    required this.isHabilitated,
  });

  factory StudentFrontModel.fromJson(Map<String, dynamic> json) =>
      StudentFrontModel(
        id: json['id'] as String,
        status: json['status'] as int,
        name: json['name'] as String,
        acronym: json['acronym'] as String,
        logo: json['logo'] as String,
        isHabilitated: json['isHabilitated'] as bool,
      );

  final String id;
  final int status;
  final String name;
  final String acronym;
  final String logo;
  final bool isHabilitated;

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'name': name,
        'acronym': acronym,
        'logo': logo,
        'isHabilitated': isHabilitated,
      };
}

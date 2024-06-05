import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str) as Map<String, dynamic>);

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    required this.id,
    required this.creationUser,
    required this.updateUser,
    required this.dateCreation,
    required this.dateUpdate,
    required this.status,
    required this.fullname,
    required this.collegeNumber,
    required this.ciNumber,
    required this.isHabilitated,
    required this.isVoted,
    required this.totalAuthorizations,
    required this.pollingTableId,
    required this.userId,
    required this.careers,
    required this.signature,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json['id'] as String,
        creationUser: json['creationUser'] as String,
        updateUser: json['updateUser'] as String,
        dateCreation: DateTime.parse(json['dateCreation'] as String),
        dateUpdate: DateTime.parse(json['dateUpdate'] as String),
        status: json['status'] as int,
        fullname: json['fullname'] as String,
        collegeNumber: json['collegeNumber'] as String,
        ciNumber: json['ciNumber'] as String,
        isHabilitated: json['isHabilitated'] as bool,
        isVoted: json['isVoted'] as bool,
        totalAuthorizations: json['totalAuthorizations'] as int,
        pollingTableId: json['pollingTableId'] as String,
        userId: json['userId'] as String,
        careers: List<String>.from(
          (json['careers'] as Iterable<dynamic>).map((x) => x as String),
        ),
        signature: json['signature'] as String,
        // signature: Signature.fromJson(
        //   json['signature'] as Map<String, dynamic>,
        // ),
      );

  String id;
  String creationUser;
  String updateUser;
  DateTime dateCreation;
  DateTime dateUpdate;
  int status;
  String fullname;
  String collegeNumber;
  String ciNumber;
  bool isHabilitated;
  bool isVoted;
  int totalAuthorizations;
  String pollingTableId;
  String userId;
  List<String> careers;
  String signature;

  Map<String, dynamic> toJson() => {
        'id': id,
        'creationUser': creationUser,
        'updateUser': updateUser,
        'dateCreation': dateCreation.toIso8601String(),
        'dateUpdate': dateUpdate.toIso8601String(),
        'status': status,
        'fullname': fullname,
        'collegeNumber': collegeNumber,
        'ciNumber': ciNumber,
        'isHabilitated': isHabilitated,
        'isVoted': isVoted,
        'totalAuthorizations': totalAuthorizations,
        'pollingTableId': pollingTableId,
        'userId': userId,
        'careers': List<dynamic>.from(careers.map((x) => x)),
        'signature': signature,
        // 'signature': signature.toJson(),
      };
}

// class Signature {
//   Signature({
//     required this.type,
//     required this.data,
//   });

//   factory Signature.fromJson(Map<String, dynamic> json) => Signature(
//         type: json['type'] as String,
//         data: List<int>.from((json['data'] as Iterable<dynamic>).map((x) => x)),
//       );

//   final String type;
//   final List<int> data;

//   Map<String, dynamic> toJson() => {
//         'type': type,
//         'data': List<dynamic>.from(data.map((x) => x)),
//       };
// }

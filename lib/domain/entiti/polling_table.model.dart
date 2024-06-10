// To parse this JSON data, do
//
//     final pollingTableModel = pollingTableModelFromJson(jsonString);

import 'dart:convert';

PollingTableModel pollingTableModelFromJson(String str) =>
    PollingTableModel.fromJson(json.decode(str) as Map<String, dynamic>);

String pollingTableModelToJson(PollingTableModel data) =>
    json.encode(data.toJson());

class PollingTableModel {
  PollingTableModel({
    required this.id,
    required this.creationUser,
    required this.updateUser,
    required this.dateCreation,
    required this.dateUpdate,
    required this.status,
    required this.numberTable,
    required this.isOpen,
    required this.electoralConfigurationId,
    required this.dateOpen,
    required this.dateClosed,
    required this.totalAuthorizations,
    required this.totalVotes,
  });

  factory PollingTableModel.fromJson(Map<String, dynamic> json) =>
      PollingTableModel(
        id: json['id'] as String,
        creationUser: json['creationUser'] as String,
        updateUser: json['updateUser'] as String,
        dateCreation: DateTime.parse(json['dateCreation'] as String),
        dateUpdate: DateTime.parse(json['dateUpdate'] as String),
        status: json['status'] as int,
        numberTable: json['numberTable'] as int,
        isOpen: json['isOpen'] as bool,
        electoralConfigurationId: json['electoralConfigurationId'] as String,
        dateOpen: DateTime.parse(json['dateOpen'].toString()),
        dateClosed: DateTime.parse(json['dateClosed'].toString()),
        totalAuthorizations: json['totalAuthorizations'] as int,
        totalVotes: json['totalVotes'] as int,
      );

  final String id;
  final String creationUser;
  final String updateUser;
  final DateTime dateCreation;
  final DateTime dateUpdate;
  final int status;
  final int numberTable;
  final bool isOpen;
  final String electoralConfigurationId;
  final DateTime dateOpen;
  final DateTime dateClosed;
  final int totalAuthorizations;
  final int totalVotes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'creationUser': creationUser,
        'updateUser': updateUser,
        'dateCreation': dateCreation.toIso8601String(),
        'dateUpdate': dateUpdate.toIso8601String(),
        'status': status,
        'numberTable': numberTable,
        'isOpen': isOpen,
        'electoralConfigurationId': electoralConfigurationId,
        'dateOpen': dateOpen.toIso8601String(),
        'dateClosed': dateClosed.toIso8601String(),
        'totalAuthorizations': totalAuthorizations,
        'totalVotes': totalVotes,
      };
}

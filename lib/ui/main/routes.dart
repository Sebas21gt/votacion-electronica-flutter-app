// ignore_for_file: strict_raw_type, inference_failure_on_instance_creation

import 'dart:convert';

import 'package:app_vote/domain/entiti/student.model.dart';
import 'package:app_vote/middleware/guarded_page.dart';
import 'package:app_vote/ui/main/global.dart';
import 'package:app_vote/ui/pages/delegates/electoral_record_delegate_page.dart';
import 'package:app_vote/ui/pages/delegates/enable_students_page.dart';
import 'package:app_vote/ui/pages/delegates/menu_delegate_page.dart';
import 'package:app_vote/ui/pages/delegates/student_data_enable.dart';
import 'package:app_vote/ui/pages/delegates/voting_table_delegate_page.dart';
import 'package:app_vote/ui/pages/login_page.dart';
import 'package:app_vote/ui/pages/student/already_vote.dart';
import 'package:app_vote/ui/pages/student/menu_student_page.dart';
import 'package:app_vote/ui/pages/student/nothing_card_voting.dart';
import 'package:app_vote/ui/pages/student/student_front_info.dart';
import 'package:app_vote/ui/pages/student/student_qr_enable_page.dart';
import 'package:app_vote/ui/pages/student/voting_card.dart';
import 'package:app_vote/ui/pages/student/voting_page.dart';
import 'package:app_vote/ui/pages/student/voting_result.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class RoutePaths {
  static const String login = '/';
  static const String noAccess = '/no-access';

  // Student routes
  static const String studentMenu = '/student';
  static const String studentsFrontInfo = '/student/students-front-info';
  static const String studentsEnableQrVoting =
      '/student/students-enable-qr-voting';
  static const String studentsVoting = '/student/students-voting';
  static const String studentsAlreadyVote = '/student/students-already-vote';
  static const String studentsResults = '/student/students-results';
  static const String studentsVotingCard = '/student/students-voting-card';
  static const String studentsNothingVoted = '/student/students-nothing-voted';

  // Delegate routes
  static const String delegateMenu = '/delegate';
  static const String enableStudents = '/delegate/enable-students';
  static const String studentDataEnable = '/delegate/student-data-enable';
  static const String electoralRecord = '/delegate/electoral-record';
  static const String votingTable = '/delegate/voting-table';
}

final Map<String, Page Function(RouteData)> commonRoutes = {
  RoutePaths.login: (route) => const MaterialPage(child: LoginPage()),
  RoutePaths.noAccess: (route) => const MaterialPage(
        child: Scaffold(body: Center(child: Text('No Access'))),
      ),
};

final Map<String, Page Function(RouteData)> studentRoutes = {
  RoutePaths.studentMenu: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.studentRoleId,
          child: MenuStudentPage(),
        ),
      ),
  RoutePaths.studentsFrontInfo: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.studentRoleId,
          child: StudentFrontInfoPage(),
        ),
      ),
  RoutePaths.studentsVoting: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.studentRoleId,
          child: VotingPage(),
        ),
      ),
  RoutePaths.studentsEnableQrVoting: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.studentRoleId,
          child: StudentQrEnablePage(),
        ),
      ),
  RoutePaths.studentsAlreadyVote: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.studentRoleId,
          child: AlreadyVotePage(),
        ),
      ),
  RoutePaths.studentsResults: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.studentRoleId,
          child: ResultVotingPage(),
        ),
      ),
  RoutePaths.studentsVotingCard: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.studentRoleId,
          child: VotingCardPage(),
        ),
      ),
  RoutePaths.studentsNothingVoted: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.studentRoleId,
          child: NotYetVotedPage(),
        ),
      ),
};

final Map<String, Page Function(RouteData)> delegateRoutes = {
  RoutePaths.delegateMenu: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.delegateRoleId,
          child: MenuDelegatePage(),
        ),
      ),
  RoutePaths.enableStudents: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.delegateRoleId,
          child: EnableStudentsDelegatePage(),
        ),
      ),
  RoutePaths.studentDataEnable: (routeData) {
    final studentJson = routeData.queryParameters['student'];
    if (studentJson != null) {
      final student = StudentModel.fromJson(
          jsonDecode(studentJson) as Map<String, dynamic>);
      return MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.delegateRoleId,
          child: StudentDataEnablePage(student: student),
        ),
      );
    } else {
      return const MaterialPage(
        child: Scaffold(body: Center(child: Text('Student data not found'))),
      );
    }
  },
  RoutePaths.electoralRecord: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.delegateRoleId,
          child: ElectoralRecordDelegatePage(),
        ),
      ),
  RoutePaths.votingTable: (route) => const MaterialPage(
        child: GuardedPage(
          requiredRole: GlobalConfig.delegateRoleId,
          child: VotingTableDelegatePage(),
        ),
      ),
};

final RouteMap authRoutes = RouteMap(
  routes: {
    ...commonRoutes,
    RoutePaths.studentMenu: (route) => const MaterialPage(
          child: GuardedPage(
            requiredRole: GlobalConfig.studentRoleId,
            child: MenuStudentPage(),
          ),
        ),
    RoutePaths.delegateMenu: (route) => const MaterialPage(
          child: GuardedPage(
            requiredRole: GlobalConfig.delegateRoleId,
            child: MenuDelegatePage(),
          ),
        ),
  },
);

RouteMap authenticatedRoutes(String role) {
  if (role == GlobalConfig.studentRoleId) {
    return RouteMap(
      routes: {
        ...commonRoutes,
        ...studentRoutes,
      },
    );
  } else if (role == GlobalConfig.delegateRoleId) {
    return RouteMap(
      routes: {
        ...commonRoutes,
        ...delegateRoutes,
      },
    );
  } else {
    return RouteMap(
      routes: {
        ...commonRoutes,
        RoutePaths.noAccess: (route) => const MaterialPage(
              child: Scaffold(body: Center(child: Text('No Access'))),
            ),
      },
    );
  }
}

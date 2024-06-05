import 'package:app_vote/providers/student_provider.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/widgets/atoms/drawer_custom.dart';
import 'package:flutter/material.dart';

final studentDrawerItems = [
  DrawerItem(
    icon: Icons.groups,
    title: 'Frentes Estudiantiles',
    route: RoutePaths.studentsFrontInfo,
  ),
  DrawerItem(
    icon: Icons.how_to_vote,
    title: 'Votaciones Estudiantiles',
    route: RoutePaths.studentsEnableQrVoting,
    onPressedAction: (context, ref) {
      ref.read(studentProvider.notifier).checkStudentStatusAndNavigate(context);
    },
  ),
  DrawerItem(
    icon: Icons.bar_chart,
    title: 'Resultados Estudiantiles',
    route: RoutePaths.studentsResults,
  ),
  DrawerItem(
    icon: Icons.contact_page,
    title: 'Carnet de Sufragio',
    route: RoutePaths.studentsVotingCard,
    onPressedAction: (context, ref) {
      ref.read(studentProvider.notifier).checkStudentIsVoteAndNavigate(context);
    },
  ),
  DrawerItem(
    icon: Icons.info,
    title: 'Mi Información',
    route: '',
  ),
];

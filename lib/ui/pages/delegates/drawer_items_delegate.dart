import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/widgets/atoms/drawer_custom.dart';
import 'package:flutter/material.dart';

final delegateDrawerItems = [
  DrawerItem(
    icon: Icons.qr_code,
    title: 'Habilitar Estudiantes',
    route: RoutePaths.enableStudents,
  ),
  DrawerItem(
    icon: Icons.description,
    title: 'Acta de Escrutinio',
    route: RoutePaths.electoralRecord,
  ),
  DrawerItem(
    icon: Icons.how_to_vote,
    title: 'Mesa de Sufragio',
    route: RoutePaths.votingTable,
  ),
  DrawerItem(
    icon: Icons.info,
    title: 'Mi Información',
    route: '',
  ),
];

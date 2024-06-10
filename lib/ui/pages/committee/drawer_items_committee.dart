// import 'package:app_vote/providers/student_provider.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/widgets/atoms/drawer_custom.dart';
import 'package:flutter/material.dart';

final committeeDrawerItems = [
  DrawerItem(
    icon: Icons.how_to_vote,
    title: 'Abrir Votaciones',
    route: RoutePaths.studentsFrontInfo,
  ),
  DrawerItem(
    icon: Icons.signal_cellular_no_sim_outlined,
    title: 'Cerrar Acta Electoral',
    route: RoutePaths.studentsEnableQrVoting,
    // onPressedAction: (context, ref) {
    //   ref.read(studentProvider.notifier).checkStudentStatusAndNavigate(context);
    // },
  ),
  DrawerItem(
    icon: Icons.info,
    title: 'Mi Información',
    route: '',
  ),
];

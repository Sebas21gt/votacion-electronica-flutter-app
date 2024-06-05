import 'package:app_vote/providers/student_provider.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/pages/student/drawer_items_student.dart';
import 'package:app_vote/ui/widgets/atoms/drawer_custom.dart';
import 'package:app_vote/ui/widgets/atoms/menu_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuStudentPage extends ConsumerWidget {
  const MenuStudentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Estudiante'),
      ),
      drawer: CustomDrawer(drawerItems: studentDrawerItems),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const MenuButton(
              title: 'Frentes \nEstudiantiles',
              imagePath: 'assets/icons/info-100.png',
              route: RoutePaths.studentsFrontInfo,
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: 'Votaciones \nEstudiantiles',
              imagePath: 'assets/icons/voting-100.png',
              route: RoutePaths.studentsEnableQrVoting,
              onPressedAction: () {
                ref
                    .read(studentProvider.notifier)
                    .checkStudentStatusAndNavigate(context);
              },
            ),
            const SizedBox(height: 16),
            const MenuButton(
              title: 'Resultados \nEstudiantiles',
              imagePath: 'assets/icons/results-100.png',
              route: RoutePaths.studentsResults,
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: 'Carnet \nde Sufragio',
              imagePath: 'assets/icons/contact-100.png',
              route: RoutePaths.studentsVotingCard,
              onPressedAction: () {
                ref
                    .read(studentProvider.notifier)
                    .checkStudentIsVoteAndNavigate(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

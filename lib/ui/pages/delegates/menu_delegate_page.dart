import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/pages/delegates/drawer_items_delegate.dart';
import 'package:app_vote/ui/widgets/atoms/drawer_custom.dart';
import 'package:app_vote/ui/widgets/atoms/menu_button_custom.dart';
import 'package:flutter/material.dart';

class MenuDelegatePage extends StatelessWidget {
  const MenuDelegatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Delegado'),
      ),
      drawer: CustomDrawer(drawerItems: delegateDrawerItems),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            MenuButton(
              title: 'Habilitar \nEstudiante',
              imagePath: 'assets/icons/qr-100.png',
              route: RoutePaths.enableStudents,
            ),
            SizedBox(height: 16),
            MenuButton(
              title: 'Acta de \nEscrutinio',
              imagePath: 'assets/icons/Paper-100.png',
              route: RoutePaths.electoralRecord,
            ),
            SizedBox(height: 16),
            MenuButton(
              title: 'Mesa \nde Sufragio',
              imagePath: 'assets/icons/Table.png',
              route: RoutePaths.votingTable,
            ),
          ],
        ),
      ),
    );
  }
}

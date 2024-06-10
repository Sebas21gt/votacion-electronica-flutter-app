import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/pages/committee/drawer_items_committee.dart';
import 'package:app_vote/ui/widgets/atoms/drawer_custom.dart';
import 'package:app_vote/ui/widgets/atoms/menu_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuCommittePage extends ConsumerWidget {
  const MenuCommittePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Comité'),
      ),
      drawer: CustomDrawer(drawerItems: committeeDrawerItems),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            MenuButton(
              title: 'Iniciar \nVotaciones',
              imagePath: 'assets/icons/open-sign.png',
              route: RoutePaths.delegateMenu,
            ),
            SizedBox(height: 16),
            MenuButton(
              title: 'Cerrar \nActa Electoral',
              imagePath: 'assets/icons/lock-100.png',
              route: RoutePaths.committeeElectoralRecord,
            ),
          ],
        ),
      ),
    );
  }
}

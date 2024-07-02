import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/pages/committee/drawer_items_committee.dart';
import 'package:app_vote/ui/widgets/atoms/drawer_custom.dart';
import 'package:app_vote/ui/widgets/atoms/menu_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_vote/providers/open_election_provider.dart';

class MenuCommittePage extends ConsumerWidget {
  const MenuCommittePage({super.key});

  Future<void> _confirmAndOpenElection(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: const Text('¿Está seguro de que desea iniciar las elecciones estudiantiles?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCELAR'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('ACEPTAR'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(openElectionProvider.notifier).openElection();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(openElectionProvider, (previous, state) {
      state.when(
        data: (_) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Elección abierta con éxito')),
        ),
        error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        ),
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Comité'),
      ),
      drawer: CustomDrawer(drawerItems: committeeDrawerItems),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MenuButton(
              title: 'Iniciar \nVotación',
              imagePath: 'assets/icons/open-sign.png',
              route: null,
              onPressedAction: () => _confirmAndOpenElection(context, ref),
            ),
            const SizedBox(height: 16),
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

import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({
    required this.drawerItems,
    super.key,
  });

  final List<DrawerItem> drawerItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Nombre del Usuario'),
            accountEmail: const Text('usuario@correo.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: primary,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo_sf.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ...drawerItems.map(
            (item) => ListTile(
              leading: Icon(item.icon, color: primary),
              title: Text(
                item.title,
                style: const TextStyle(color: primary),
              ),
              onTap: () {
                Navigator.pop(context);
                if (item.onPressedAction != null) {
                  item.onPressedAction!(context, ref);
                } else {
                  Routemaster.of(context).push(item.route);
                }
              },
            ),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: primary,
            ),
            title: const Text(
              'Cerrar Sesión',
              style: TextStyle(color: primary),
            ),
            onTap: () {
              ref.read(authProvider.notifier).logout(context);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
    this.onPressedAction,
  });

  final IconData icon;
  final String title;
  final String route;
  final void Function(BuildContext context, WidgetRef ref)? onPressedAction;
}

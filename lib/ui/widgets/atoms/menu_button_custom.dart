import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class MenuButton extends ConsumerWidget {
  const MenuButton({
    required this.title,
    required this.imagePath,
    required this.route,
    this.onPressedAction,
    super.key,
  });

  final String title;
  final String imagePath;
  final String route;
  final VoidCallback? onPressedAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        backgroundColor: secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        if (onPressedAction != null) {
          onPressedAction!();
        } else{
          Routemaster.of(context).push(route);
        }
        // Routemaster.of(context).push(route);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            imagePath,
            width: 60,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}

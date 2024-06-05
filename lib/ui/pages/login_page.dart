// ignore_for_file: library_private_types_in_public_api

import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:app_vote/ui/widgets/atoms/button_custom.dart';
import 'package:app_vote/ui/widgets/atoms/form_custom.dart';
import 'package:app_vote/ui/widgets/atoms/headers_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordVisible = ref.watch(passwordVisibilityProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderCustom(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FormCustom(
                          labelText: 'Carnet de identidad',
                          iconprefix: Icons.person,
                          iconprefixRequired: true,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 10),
                        FormCustom(
                          labelText: 'Contraseña',
                          iconprefix: Icons.lock,
                          iconprefixRequired: true,
                          controller: _passwordController,
                          obscureText: passwordVisible,
                          iconsuffix: passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          iconsuffixRequired: true,
                          onSuffixIconTap: () => ref
                              .read(passwordVisibilityProvider.notifier)
                              .toggleVisibility(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Olvidé mi contraseña',
                                style: TextStyle(color: primary),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Nota: Si es la primera vez que ingresas al sistema, la contraseña será tu Número de CI. Ej: 12345678',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textColor),
                        ),
                        const SizedBox(height: 40),
                        ButtonCustom(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await ref.read(authProvider.notifier).login(
                                    _emailController.text,
                                    _passwordController.text,
                                    context,
                                  );
                            }
                          },
                          text: 'INGRESAR',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

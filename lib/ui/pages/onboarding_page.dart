import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:routemaster/routemaster.dart';
import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/main/styles.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Explora las opciones de votación',
          body:
              'Explora las opciones de votación, conoce a los candidatos, participa de las elecciones y vota por tu candidato favorito.',
          image: Center(
            child: Image.asset('assets/images/onboarding1.png', height: 175.0),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            bodyTextStyle: TextStyle(fontSize: 14.0, color: Colors.white),
            pageColor: primary,
            imagePadding: EdgeInsets.all(24.0),
            // descriptionPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
        PageViewModel(
          title: 'Voto protegido',
          body:
              'Tu voto está protegido con cifrado avanzado y medidas antifraude. Vota con confianza desde la seguridad de tu dispositivo.',
          image: Center(
            child: Image.asset(
              'assets/images/onboarding2.png',
              height: 175.0,
            ),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            bodyTextStyle: TextStyle(fontSize: 14.0, color: Colors.white),
            pageColor: primary,
            imagePadding: EdgeInsets.all(24.0),
            // descriptionPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
        PageViewModel(
          title: 'Accede a resultados',
          body:
              'Accede a resultados y estadísticas en tiempo real al finalizar la votación. Mantente informado de manera rápida y eficiente.',
          image: Center(
            child: Image.asset(
              'assets/images/onboarding3.png',
              height: 175.0,
            ),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            bodyTextStyle: TextStyle(fontSize: 14.0, color: Colors.white),
            pageColor: primary,
            imagePadding: EdgeInsets.all(24.0),
            // descriptionPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ],
      onDone: () async {
        await ref.read(authProvider.notifier).completeOnboarding();
        Routemaster.of(context).replace(RoutePaths.login);
      },
      onSkip: () async {
        await ref.read(authProvider.notifier).completeOnboarding();
        Routemaster.of(context).replace(RoutePaths.login);
      },
      showSkipButton: true,
      skip: const Text('Saltar'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Hecho', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: primary,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

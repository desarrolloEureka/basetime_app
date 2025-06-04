import 'package:basetime/features/auth/auth_page.dart';
import 'package:basetime/features/onboarding/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  static String name = 'Onboarding';
  static String path = '/onboarding';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> texts = [
      {
        'title': 'Contecta',
        'description':
            'Explora un mundo lleno de oportunidades conectándote con profesionales y expertos que comparten tus intereses. Desde colaboraciones hasta mentorías, descubre cómo expandir tus horizontes y construir relaciones valiosas para tu crecimiento personal y profesional. ¡Cada conexión puede ser el inicio de algo extraordinario!',
      },
      {
        'title': 'Monetiza',
        'description':
            'Transforma tu pasión en ingresos mientras compartes lo que más disfrutas hacer. Nuestra plataforma te ayuda a llegar a las personas que valoran tu talento, permitiéndote ganar dinero haciendo lo que amas. ¡Es el momento de convertir tus habilidades en recompensas reales!',
      },
      {
        'title': 'Aprende',
        'description':
            'Entra en un espacio donde las pasiones se convierten en aprendizajes. Descubre, de la mano de otros, nuevos conocimientos, habilidades y perspectivas que pueden inspirarte a crecer y reinventarte. Cada historia y experiencia compartida puede ser una fuente de aprendizaje sin límites.',
      }
    ];

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: List<Widget>.generate(
          3,
          (int index) {
            final number = index + 1;
            final text = texts[index];
            return OnboardingWidget(
              number: number,
              title: text['title'] as String,
              description: text['description'] as String,
              onSkip: () {
                context.pushReplacementNamed(AuthPage.name);
              },
              onNext: number == 3
                  ? () {
                      context.pushReplacementNamed(AuthPage.name);
                    }
                  : () {
                      pageController.animateToPage(
                        number,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    },
            );
          },
        ),
      ),
    );
  }
}

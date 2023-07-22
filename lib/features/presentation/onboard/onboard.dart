import 'package:flutter/material.dart';
import 'package:rent_house_app/features/presentation/onboard/widgets/get_started_button.dart';
import 'package:rent_house_app/features/presentation/onboard/widgets/image_list_view.dart';
import 'package:rent_house_app/features/presentation/onboard/widgets/onboard_content.dart';
import 'package:rent_house_app/features/presentation/onboard/widgets/smooth_dots_indicator.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({
    super.key,
  });
  final List<Widget> titlesList = [
    const OnboardTextContent(
      title: 'Procure pelo teu próximo cúbico com apenas um click.',
    ),
    const OnboardTextContent(
      title:
          'Registra-se com seu número de telefone, e troque mensagens com o vendedor, na maior calma.',
    ),
    const OnboardTextContent(
      title: 'Todos vendedores aqui, são confiáveis, e verificados.',
    ),
  ];
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -10,
            left: -120,
            child: Row(
              children: const [
                ImageListView(startIndex: 0),
                ImageListView(startIndex: 1),
                ImageListView(startIndex: 2),
              ],
            ),
          ),

          //Info bottom
          Positioned(
            bottom: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                    Colors.black,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Mô Cubico',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  OnboardTitles(
                    controller: _controller,
                    titlesList: titlesList,
                  ),
                  SmoothDotsIndicator(
                    controller: _controller,
                    titlesList: titlesList,
                  )
                ],
              ),
            ),
          ),
          //Button
          const GetStartedButton()
        ],
      ),
    );
  }
}

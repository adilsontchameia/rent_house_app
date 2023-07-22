import 'package:flutter/material.dart';
import 'package:rent_house_app/features/presentation/onboard/widgets/image_list_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({
    super.key,
  });
  final List<Widget> titlesList = [
    const OnboardTextTile(
      title: 'Procure pelo teu próximo cúbico com apenas um click.',
    ),
    const OnboardTextTile(
      title:
          'Registra-se com seu número de telefone, e troque mensagens com o vendedor, na maior calma.',
    ),
    const OnboardTextTile(
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
          const GetStartedButton(index: 0)
        ],
      ),
    );
  }
}

class OnboardTextTile extends StatelessWidget {
  const OnboardTextTile({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

class OnboardTitles extends StatelessWidget {
  const OnboardTitles({
    super.key,
    required PageController controller,
    required this.titlesList,
  }) : _controller = controller;

  final PageController _controller;
  final List<Widget> titlesList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: PageView(
            controller: _controller,
            children: titlesList,
          ),
        ));
  }
}

class SmoothDotsIndicator extends StatelessWidget {
  const SmoothDotsIndicator({
    super.key,
    required PageController controller,
    required this.titlesList,
  }) : _controller = controller;

  final PageController _controller;
  final List<Widget> titlesList;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _controller,
      count: titlesList.length,
      effect: const JumpingDotEffect(
        activeDotColor: Colors.white,
        dotColor: Colors.grey,
        dotHeight: 10.0,
        dotWidth: 10.0,
        jumpScale: 2.0,
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 30.0,
        left: 20.0,
        right: 20.0,
        child: SizedBox(
          height: 50.0,
          child: AbsorbPointer(
            absorbing: index == index ? false : true,
            child: ElevatedButton(
              onPressed: () {
                print('Navigated');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              child: const Text(
                'Começar',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ));
  }
}

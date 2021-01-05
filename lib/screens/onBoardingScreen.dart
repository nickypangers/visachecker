import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

List<PageViewModel> getPages() {
  return [
    PageViewModel(
      title: 'Latest Information',
      image: Image.asset('assets/launcher/Icon-144.png'),
      body: 'Up-to-date visa information for stressless travel planning.',
    ),
    PageViewModel(
      title: 'All in One',
      image: Image.asset('assets/launcher/Icon-144.png'),
      body: 'Includes latest weather, currency exchange rates and more.',
    ),
    PageViewModel(
      title: 'Community First',
      image: Image.asset('assets/launcher/Icon-144.png'),
      body: 'Active development team and community information reporting.',
    ),
  ];
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: getPages(),
      onDone: () => print('done'),
      showNextButton: true,
      next: const Icon(Icons.arrow_forward),
      nextFlex: 0,
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visachecker/common/screens/content_screen.dart';
import 'package:visachecker/common/transitions/reveal_route.dart';
// import 'package:visa_checker/common/constants.dart';
// import 'package:visa_checker/screens/ContentScreen.dart';
import 'package:visachecker/common/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

List<PageViewModel> getPages(BuildContext context) {
  return [
    PageViewModel(
      titleWidget: Text(
        // 'Latest Information',
        AppLocalizations.of(context)?.latestInformation ?? "Latest Information",
        style: kOnBoardingTitleTextStyle,
        textAlign: TextAlign.center,
      ),
      image: Image.asset('assets/launcher/Icon-144.png'),
      bodyWidget: Text(
        // 'Up-to-date visa information for stressless travel planning.',
        AppLocalizations.of(context)?.latestInformationText ??
            "Up-to-date visa information for stressless travel planning.",
        style: kOnBoardingBodyTextStyle,
        textAlign: TextAlign.center,
      ),
    ),
    PageViewModel(
      titleWidget: Text(
        // 'All in One',
        AppLocalizations.of(context)?.allInOne ?? "All In One",
        style: kOnBoardingTitleTextStyle,
        textAlign: TextAlign.center,
      ),
      image: Image.asset('assets/launcher/Icon-144.png'),
      bodyWidget: Text(
        AppLocalizations.of(context)?.allInOneText ??
            'Includes latest weather, currency exchange rates and more.',
        // 'Includes latest weather, currency exchange rates and more.',
        style: kOnBoardingBodyTextStyle,
        textAlign: TextAlign.center,
      ),
    ),
    PageViewModel(
      titleWidget: Center(
        child: Text(
          AppLocalizations.of(context)?.forTravellersByTravellers ??
              'For Travellers, By Travellers',
          // 'For Travellers, By Travellers',
          style: kOnBoardingTitleTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      image: Image.asset('assets/launcher/Icon-144.png'),
      bodyWidget: Text(
        AppLocalizations.of(context)?.forTravellersByTravellersText ??
            'Developed by a team of avid travellers.',
        // 'Developed by a team of avid travellers.',
        style: kOnBoardingBodyTextStyle,
        textAlign: TextAlign.center,
      ),
    ),
  ];
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: getPages(context),
      globalBackgroundColor: kIconBackgroundColor,
      onDone: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isReturning", true);
        Navigator.pushReplacement(
          context,
          RevealRoute(
            page: const ContentScreen(),
            maxRadius: 800,
            centerAlignment: Alignment.center,
          ),
        );
      },
      showNextButton: true,
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      nextFlex: 0,
      done: Text(
        AppLocalizations.of(context)?.done ?? 'Done',
        // 'Done',
        style: kOnBoardingButtonTextStyle,
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFF0F0F0),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

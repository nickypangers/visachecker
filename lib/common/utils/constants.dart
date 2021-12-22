import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Environment

enum Environment {
  local,
  development,
  production,
}

const kEnvironment = Environment.production;

// String

const kVisaFree = "VF";
const kVisaOnArrival = "VOA";
const kVisaRequired = "VR";
const kCovidBan = "CB";
const kNoAdmission = "NA";

const kVisaFreeString = "Visa Free";
const kVisaOnArrivalString = "Visa On Arrival";
const kVisaRequiredString = "Visa Required";
const kCovidBanString = "Covid Ban";
const kNoAdmissionString = "No Admission";

// IconData

const kVisaFreeIconData = FontAwesomeIcons.check;
const kVisaOnArrivalIconData = FontAwesomeIcons.minus;
const kVisaRequiredIconData = FontAwesomeIcons.times;
const kCovidBanIconData = FontAwesomeIcons.times;
const kNoAdmissionIconData = FontAwesomeIcons.times;

// API
// const kUrl = isDev
//     ? "http://passport-visa-api-dev.herokuapp.com/"
//     : "http://passportvisa-api.herokuapp.com/";

// Sidebar
const kTabWidth = 35.0;

const kSidebarMargin = 10.0;

const kTotalLeftMargin = kTabWidth + kSidebarMargin + 5;

// Color Scheme
const Color kIconBackgroundColor = Color(0xFF00d46d);

// const Color kBackgroundColor = Colors.white;
const Color kBackgroundColor = Color(0xFF003D00);

const Color kLocationUnselectedColor = Color(0xffa9aaae);

const Color kLocationSelectedColor = Color(0xff7cacc0);

const Color kScaffoldColor = Color(0xffE7EAD7);

const Color kPrimaryColor = Color(0xfffffaf2);

const Color kSidebarPrimaryColor = Color(0xFF262AAA);

const Color kVisaFreeColor = Color(0xFF00d46d);

const Color kVisaOnArrivalColor = Color(0xFFffcc14);

const Color kVisaRequiredColor = Color(0xFFff4314);

const Color kCovidBanColor = Color(0xFFff4314);

const Color kNoAdmissionColor = Color(0xFFff4314);

// Text Scheme
const TextStyle kOnBoardingButtonTextStyle = TextStyle(
  fontSize: 14,
  color: Colors.white,
);

const TextStyle kOnBoardingTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.w600,
);

const TextStyle kOnBoardingBodyTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

const TextStyle kHomeCircleTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const TextStyle kHomeCircleTitleTextStyle = TextStyle(
  color: Colors.white,
);

const TextStyle kViewMoreTextStyle = TextStyle(color: Colors.blue);

const TextStyle kSearchResultStatusTextStyle = TextStyle(fontSize: 20);
const TextStyle kSearchResultDurationTextStyle = TextStyle(fontSize: 16);

const TextStyle kListInfoTextStyle = TextStyle(fontWeight: FontWeight.w600);

const TextStyle kAboutAppTitleTextStyle =
    TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
const TextStyle kAboutAppInfoTextStyle = TextStyle(fontSize: 20);
const TextStyle kAboutPersonalTextStyle = TextStyle(fontSize: 16);
const TextStyle kAboutLinkTextStyle = TextStyle(
    color: Colors.blue, decoration: TextDecoration.underline, fontSize: 16);

// Font Size

const double kHeading1 = 25;

// Image Path
const String kIconPath = "assets/launcher/Icon-144.png";

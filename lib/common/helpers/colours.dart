import 'package:flutter/material.dart';
import 'package:visachecker/common/utils/constants.dart';

Color getColor(String category) {
  switch (category) {
    case kVisaRequired:
      return kVisaRequiredColor;
    case kVisaOnArrival:
      return kVisaOnArrivalColor;
    case kVisaFree:
      return kVisaFreeColor;
    case kCovidBan:
      return kCovidBanColor;
    case kNoAdmission:
      return kNoAdmissionColor;
    default:
      return kNoAdmissionColor;
  }
}

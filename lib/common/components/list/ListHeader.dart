import 'package:flutter/material.dart';
import 'package:visachecker/common/utils/constants.dart';

class ListHeader extends StatelessWidget {
  // const ListHeader({Key? key}) : super(key: key);

  final String leftTitle;
  final String rightTitle;

  ListHeader({required this.leftTitle, required this.rightTitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide())),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 9,
                  // horizontal: 8,
                ),
                child: Text(
                  leftTitle,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Center(
                  child: Text(
                    rightTitle,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}

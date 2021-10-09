import 'package:flutter/material.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/common/utils/constants.dart';

class ListRow extends StatelessWidget {
  // const ListRow({Key? key}) : super(key: key);

  final String countryName;
  final Destination destination;

  ListRow({required this.countryName, required this.destination, Key? key})
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
                child: Text(countryName),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                color: getColor(destination.category!),
                child: Center(
                    child: Text(
                  destination.status!,
                  textAlign: TextAlign.center,
                )),
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

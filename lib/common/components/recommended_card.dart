import 'package:flutter/material.dart';
import 'package:visa_checker/common/models/country.dart';

class RecommendedCard extends StatelessWidget {
  final Country country;

  RecommendedCard({
    this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.blue,
      ),
      width: 150,
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Image.network(
                'https://www.smartcitiesworld.net/AcuCustom/Sitename/DAM/019/Sydney_Harbour_at_night_Adobe.jpg'),
            Text("${country.countryName}"),
          ],
        ),
      ),
    );
  }
}

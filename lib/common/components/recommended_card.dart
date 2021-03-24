import 'package:flutter/material.dart';
import 'package:visa_checker/common/api/google_places.dart';
import 'package:visa_checker/common/models/country.dart';
import 'package:visa_checker/keys/keys.dart';

class RecommendedCard extends StatelessWidget {
  final Country country;

  RecommendedCard({
    this.country,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("hi");
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // child: Image.network(
              //   "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${country.photo}&key=$googlePlacesKey",
              //   width: 150,
              //   height: 150,
              //   fit: BoxFit.cover,
              // ),
              child: Image.asset(
                "assets/images/${country.countryCode}.jpg",
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Text(
                  "${country.countryName}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue,
        ),
        width: 150,
        margin: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.network(
              "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${country.photo}&key=$googlePlacesKey",
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}

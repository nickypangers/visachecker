import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/api/google_places.dart';
import 'package:visa_checker/common/api/visa.dart';
import 'package:visa_checker/common/models/country.dart';
import 'package:visa_checker/keys/keys.dart';

class RecommendedCard extends StatelessWidget {
  final Country country;
  final String visa;

  RecommendedCard({
    this.country,
    this.visa,
  });

  var height = 20.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<Country>(
      builder: (context, currentCountry, child) => GestureDetector(
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
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "${country.countryName}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    _buildVisaResult(height, visa),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildVisaResult(double height, String visa) {
    if (visa == null) {
      return Container(
        height: height,
        width: 85,
        color: Colors.grey[200],
      );
    }
    return Container(
      height: height,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Text(
          "$visa",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/components/recommended_card.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/navigation.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/common/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  String _getCurrentTime() {
    var now = DateTime.now();

    return DateFormat('kk').format(now);
  }

  String _getGreetings(String hourString) {
    int hour = int.parse(hourString);

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    }
    if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    }
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: kSidebarMargin + 10, right: 10),
        child: Consumer<Country>(
          builder: (context, currentCountry, child) =>
              _buildMain(context, currentCountry),
        ),
      ),
    );
  }

  Widget _buildMain(BuildContext context, Country currentCountry) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, currentCountry),
          _buildRecommendedList(context,
              height: 170.0,
              list: Provider.of<CountryCategoryList>(context)
                  .getcountryCategoryListVf
                  .data!),
          _buildMapButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Country currentCountry) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: _buildGreetings(context),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset(
                "assets/flags/${currentCountry.code!.toLowerCase()}.svg"),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedList(BuildContext context,
      {double height = 170, required List<dynamic> list}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryHeader(context,
            title: "Visa-Free Locations", showViewMore: true),
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) => RecommendedCard(
              code: list[index],
              visa: "Visa Free",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryHeader(BuildContext context,
      {required String title,
      required bool showViewMore,
      Function()? onClick}) {
    return Padding(
      padding: const EdgeInsets.all(0),
      // padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
            ),
          ),
          showViewMore
              ? GestureDetector(
                  onTap: onClick ??
                      () {
                        debugPrint("hi");
                      },
                  child: const Text(
                    'View More',
                    style: kViewMoreTextStyle,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildGreetings(BuildContext context) {
    var currentTime = _getCurrentTime();
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: kTabWidth),
      height: 110,
      child: Text(
        _getGreetings(currentTime),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildMapButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<NavigationState>(context, listen: false)
            .setNavigation(NavigationEvents.listClickedEvent);
      },
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text("Maps"),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:visachecker/common/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: kTotalLeftMargin),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildAppInfoSection(context),
              const SizedBox(height: 15),
              _buildPersonalSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Created by Nixon Pang", style: kAboutPersonalTextStyle),
        Text("Web/Mobile App Developer"),
        InkWell(
          child: Text(
            'See My Portfolio',
            style: kAboutLinkTextStyle,
          ),
          onTap: () => launch('https://nickypangers.com'),
        )
      ],
    );
  }

  Widget _buildAppInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: SizedBox(
                height: 90,
                width: 90,
                child: Image.asset(kIconPath),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              "Visa Checker",
              style: kAboutAppTitleTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text("Version : ${_packageInfo.version} (${_packageInfo.buildNumber})",
            style: kAboutAppInfoTextStyle),
        const SizedBox(height: 10),
        InkWell(
          child: new Text(
            'See Licenses',
            style: kAboutLinkTextStyle,
          ),
          onTap: () => showLicensePage(
            context: context,
            applicationName: "Visa Checker",
            applicationIcon: Image.asset(kIconPath),
            applicationVersion:
                "${_packageInfo.version} (${_packageInfo.buildNumber})",
          ),
        )
      ],
    );
  }
}

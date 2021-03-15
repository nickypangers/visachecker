import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/models/navigation.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final NavigationEvents clickedEvent;

  MenuItem({this.icon, this.title, this.clickedEvent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<NavigationState>(context, listen: false)
            .setNavigation(this.clickedEvent);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: Color(0xffC0FCF9),
              size: 20,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

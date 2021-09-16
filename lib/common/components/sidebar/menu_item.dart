import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/models/navigation.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final NavigationEvents clickedEvent;
  final Function onPressed;

  const MenuItem(
      {Key? key,
      required this.icon,
      required this.title,
      required this.clickedEvent,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<NavigationState>(context, listen: false)
            .setNavigation(clickedEvent);

        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xffC0FCF9),
              size: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
